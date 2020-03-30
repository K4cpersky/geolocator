# frozen_string_literal: true

class Api::InternetProtocolsController < ApplicationController
  before_action :find_internet_protocol, only: %i[show delete]

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_error

  def show
    render jsonapi: @internet_protocol, include: [:location]
  end

  def delete
    head :ok
  end

  private

  def find_internet_protocol
    @internet_protocol = InternetProtocol.find(params[:id])
  end
end
