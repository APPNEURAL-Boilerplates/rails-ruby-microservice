# frozen_string_literal: true

class RootController < ApplicationController
  def show
    render_success(
      data: {
        service: Rails.configuration.x.service_name,
        version: Rails.configuration.x.app_version,
        environment: Rails.env,
        api: '/api/v1',
        timestamp: Time.current.iso8601
      }
    )
  end
end
