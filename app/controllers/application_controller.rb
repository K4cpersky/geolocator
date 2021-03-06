# frozen_string_literal: true

class ApplicationController < ActionController::API
  private

  def render_not_found_error(error)
    render_error(error.message, status: 404)
  end

  def render_not_valid_error(error)
    render_error(error.message, status: 422)
  end

  def render_wrong_ip(error)
    render_error(error.message, status: 204)
  end

  def render_error(message, status:)
    render jsonapi_errors: { detail: message }, status: status
  end
end
