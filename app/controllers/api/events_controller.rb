class API::EventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :set_access_control_headers

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Content-Type'
  end

  def create
    event = Event.create(event_params)
    event.registered_application = RegisteredApplication.find_by(url: request.env['HTTP_ORIGIN'])
    if event.save
      render json: event, status: :created
    else
      binding.pry
      render json: { errors: event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.permit(:name)
  end
end
