# frozen_string_literal: true

class ExampleJob < ApplicationJob
  queue_as :default

  def perform(payload = {})
    Rails.logger.info(message: 'example_job.perform', payload: payload)
  end
end
