# frozen_string_literal: true

Rails.application.configure do
  config.enable_reloading = true
  config.eager_load = false
  config.consider_all_requests_local = true
  config.server_timing = true
  config.log_level = ENV.fetch('RAILS_LOG_LEVEL', 'debug').to_sym
  config.cache_store = :memory_store
  config.active_support.deprecation = :log
end
