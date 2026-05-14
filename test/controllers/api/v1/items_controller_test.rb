# frozen_string_literal: true

require 'test_helper'

module API
  module V1
    class ItemsControllerTest < ActionDispatch::IntegrationTest
      test 'lists items' do
        get '/api/v1/items'

        assert_response :success
        body = JSON.parse(response.body)
        assert_equal true, body['ok']
        assert_kind_of Array, body['data']
      end

      test 'shows an item' do
        get '/api/v1/items/item-one'

        assert_response :success
        body = JSON.parse(response.body)
        assert_equal true, body['ok']
        assert_equal 'item-one', body.dig('data', 'id')
      end

      test 'creates an item' do
        post '/api/v1/items',
             params: { name: 'Keyboard', description: 'Mechanical keyboard', price: 99.99 },
             as: :json

        assert_response :created
        body = JSON.parse(response.body)
        assert_equal true, body['ok']
        assert_equal 'Keyboard', body.dig('data', 'name')
      end

      test 'rejects invalid item' do
        post '/api/v1/items',
             params: { description: 'Missing name', price: 10 },
             as: :json

        assert_response :unprocessable_entity
        body = JSON.parse(response.body)
        assert_equal false, body['ok']
        assert_equal 'VALIDATION_ERROR', body.dig('error', 'code')
      end

      test 'returns not found' do
        get '/api/v1/missing'

        assert_response :not_found
        body = JSON.parse(response.body)
        assert_equal false, body['ok']
        assert_equal 'NOT_FOUND', body.dig('error', 'code')
      end

      test 'returns method not allowed' do
        put '/api/v1/health'

        assert_response :method_not_allowed
        body = JSON.parse(response.body)
        assert_equal false, body['ok']
        assert_equal 'METHOD_NOT_ALLOWED', body.dig('error', 'code')
      end

      test 'returns invalid json error' do
        post '/api/v1/items',
             params: '{ invalid json',
             headers: { 'CONTENT_TYPE' => 'application/json' }

        assert_response :bad_request
        body = JSON.parse(response.body)
        assert_equal false, body['ok']
        assert_equal 'INVALID_JSON', body.dig('error', 'code')
      end
    end
  end
end
