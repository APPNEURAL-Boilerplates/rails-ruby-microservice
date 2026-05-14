# frozen_string_literal: true

require 'json'
require 'net/http'
require 'uri'

class HttpClient
  Response = Data.define(:status, :headers, :body)

  def initialize(base_url:, timeout: 5)
    @base_uri = URI(base_url)
    @timeout = timeout
  end

  def get(path, headers: {})
    perform(Net::HTTP::Get.new(build_uri(path), headers))
  end

  def post(path, body:, headers: {})
    request = Net::HTTP::Post.new(build_uri(path), { 'Content-Type' => 'application/json' }.merge(headers))
    request.body = JSON.generate(body)
    perform(request)
  end

  private

  def build_uri(path)
    uri = @base_uri.dup
    uri.path = File.join(@base_uri.path, path)
    uri
  end

  def perform(request)
    response = Net::HTTP.start(request.uri.hostname, request.uri.port, use_ssl: request.uri.scheme == 'https',
                                                                       read_timeout: @timeout) do |http|
      http.request(request)
    end

    Response.new(
      status: response.code.to_i,
      headers: response.each_header.to_h,
      body: parse_body(response.body)
    )
  end

  def parse_body(body)
    JSON.parse(body)
  rescue JSON::ParserError
    body
  end
end
