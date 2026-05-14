# frozen_string_literal: true

module API
  module V1
    class HealthController < ApplicationController
      def show
        render_success(
          data: {
            service: Rails.configuration.x.service_name,
            status: 'healthy',
            uptime_seconds: Process.clock_gettime(Process::CLOCK_MONOTONIC).round,
            timestamp: Time.current.iso8601
          }
        )
      end

      def ready
        database_ready = database_ready?

        render_success(
          data: {
            service: Rails.configuration.x.service_name,
            status: database_ready ? 'ready' : 'not_ready',
            checks: {
              database: database_ready ? 'ok' : 'failed'
            },
            timestamp: Time.current.iso8601
          },
          status: database_ready ? :ok : :service_unavailable
        )
      end

      private

      def database_ready?
        ActiveRecord::Base.connection_pool.with_connection(&:active?)
      rescue StandardError => e
        Rails.logger.warn(message: 'readiness.database_failed', error: e.message)
        false
      end
    end
  end
end
