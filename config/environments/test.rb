# frozen_string_literal: true

Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = ENV['CI'].present?
  config.public_file_server.enabled = true
  config.consider_all_requests_local = false
  config.action_dispatch.show_exceptions = :rescuable
  config.cache_store = :null_store
  config.active_support.deprecation = :stderr
end
