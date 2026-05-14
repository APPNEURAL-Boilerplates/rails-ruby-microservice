# frozen_string_literal: true

require 'test_helper'

module API
  module V1
    class HealthControllerTest < ActionDispatch::IntegrationTest
      test 'returns health' do
        get '/api/v1/health'

        assert_response :success
        body = JSON.parse(response.body)
        assert_equal true, body['ok']
        assert_equal 'healthy', body.dig('data', 'status')
      end

      test 'returns readiness' do
        get '/api/v1/ready'

        assert_response :success
        body = JSON.parse(response.body)
        assert_equal true, body['ok']
        assert_equal 'ready', body.dig('data', 'status')
      end
    end
  end
end
