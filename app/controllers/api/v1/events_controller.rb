class Api::V1::EventsController < ApplicationController
  before_action :authenticate_user, only: [:update, :create]

  def show
    event = Event.find(params[:id])

    render json: event, status: 200
  end

  def index
    events = find_events_by_city_and_state(params[:city], params[:state])

    render json: events, status: 200
  end

  def update
  end

  def create
  end

  def destroy
  end
end
