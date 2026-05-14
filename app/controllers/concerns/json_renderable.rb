# frozen_string_literal: true

module JsonRenderable
  extend ActiveSupport::Concern

  private

  def render_success(data: nil, message: nil, status: :ok, meta: nil)
    body = { ok: true }
    body[:message] = message if message.present?
    body[:data] = data unless data.nil?
    body[:meta] = meta if meta.present?

    render json: body, status: status
  end

  def render_error(code:, message:, status:, details: nil)
    body = {
      ok: false,
      error: {
        code: code,
        message: message
      }
    }
    body[:error][:details] = details if details.present?

    render json: body, status: status
  end
end
