# frozen_string_literal: true

Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.log_level = ENV.fetch('RAILS_LOG_LEVEL', 'info').to_sym
  config.log_tags = [:request_id]
  config.cache_store = :memory_store
  config.active_support.report_deprecations = false
  config.force_ssl = ENV.fetch('FORCE_SSL', 'false') == 'true'
end
