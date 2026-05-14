# frozen_string_literal: true

class EventPublisher
  def publish(topic, payload)
    Rails.logger.info(
      message: 'event.publish',
      topic: topic,
      payload: payload
    )

    true
  end
end
