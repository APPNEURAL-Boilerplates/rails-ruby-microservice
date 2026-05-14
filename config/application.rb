# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module RailsMicroserviceBoilerplate
  class Application < Rails::Application
    config.load_defaults 8.1

    config.api_only = true

    config.x.service_name = ENV.fetch('SERVICE_NAME', 'rails-microservice')
    config.x.app_version = ENV.fetch('APP_VERSION', '0.1.0')

    config.time_zone = 'UTC'
    config.active_job.queue_adapter = :async
    config.log_tags = [:request_id]

    config.action_dispatch.rescue_responses.merge!(
      'AppError' => :bad_request,
      'ActionDispatch::Http::Parameters::ParseError' => :bad_request
    )
  end
end
