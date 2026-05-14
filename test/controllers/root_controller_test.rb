# frozen_string_literal: true

require 'test_helper'

class RootControllerTest < ActionDispatch::IntegrationTest
  test 'returns service metadata' do
    get '/'

    assert_response :success
    body = JSON.parse(response.body)
    assert_equal true, body['ok']
    assert_equal 'rails-microservice', body.dig('data', 'service')
  end
end
