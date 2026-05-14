# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JsonRenderable

  before_action :set_request_id_header

  rescue_from AppError, with: :handle_app_error
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid
  rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
  rescue_from ActionDispatch::Http::Parameters::ParseError, with: :handle_invalid_json

  def not_found
    render_error(
      code: 'NOT_FOUND',
      message: 'Route not found',
      status: :not_found
    )
  end

  def method_not_allowed
    allowed_methods = allowed_methods_for(request.path)
    response.set_header('Allow', allowed_methods.join(', ')) if allowed_methods.any?

    render_error(
      code: 'METHOD_NOT_ALLOWED',
      message: "HTTP method #{request.request_method} is not allowed for #{request.path}",
      status: :method_not_allowed,
      details: { allowed_methods: allowed_methods }
    )
  end

  private

  def set_request_id_header
    response.set_header('X-Request-Id', request.request_id)
  end

  def handle_app_error(error)
    render_error(
      code: error.code,
      message: error.message,
      status: error.status,
      details: error.details
    )
  end

  def handle_not_found(error)
    render_error(
      code: 'NOT_FOUND',
      message: error.message,
      status: :not_found
    )
  end

  def handle_record_invalid(error)
    render_error(
      code: 'VALIDATION_ERROR',
      message: 'Validation failed',
      status: :unprocessable_entity,
      details: error.record.errors.to_hash(true)
    )
  end

  def handle_parameter_missing(error)
    render_error(
      code: 'BAD_REQUEST',
      message: error.message,
      status: :bad_request
    )
  end

  def handle_invalid_json(_error)
    render_error(
      code: 'INVALID_JSON',
      message: 'Request body contains invalid JSON',
      status: :bad_request
    )
  end

  def allowed_methods_for(path)
    case path
    when '/'
      ['GET']
    when '/api/v1/health', '/api/v1/ready'
      ['GET']
    when '/api/v1/items'
      %w[GET POST]
    when %r{\A/api/v1/items/[^/]+\z}
      ['GET']
    else
      []
    end
  end
end
