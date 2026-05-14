# frozen_string_literal: true

class AppError < StandardError
  attr_reader :code, :status, :details

  def initialize(message, code: 'APP_ERROR', status: :bad_request, details: nil)
    super(message)
    @code = code
    @status = status
    @details = details
  end
end
