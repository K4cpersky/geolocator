# frozen_string_literal: true

class Api::InternetProtocolsController < ApplicationController
  before_action :find_internet_protocol, only: %i[show]

  rescue_from ActiveRecord::RecordNotFound, with: :render_event_not_found

  def show
    render jsonapi: @record,
           include: :location
  end

  private

  def find_internet_protocol
    @internet_protocol = InternetProtocol.find(params[:id])
  end

  def render_internet_protocol_not_found(error)
    render json: error, status: 404
  end
end
