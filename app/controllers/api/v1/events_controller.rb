class Api::V1::EventsController < ApiController
  before_action :authenticate_user, only: [:update, :create, :destroy]

  def show
    event = Event.find(params[:id])

    render json: event, status: 200
  end

  def index
    events = Event.find_events_by_city_and_state(params[:city].downcase, params[:state].downcase)

    if !events.empty?
      render json: events, status: 200
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def update
    event = Event.find(params[:id])
    if authorized?(event) && event.update(event_params)
      render status: 200, json: { event: "#{event.event_name}", updated: "Yes" }
    end
  end

  def create
    event = current_user.event.new(event_params)

    if event.save!
      render status: 200, json: { event: "#{event.event_name}", created: "Yes"}
    end
  end

  def destroy
    event = Event.find(params[:id])

    if authorized?(event) && event.destroy
      render status: 200, json: { event: "#{event.event_name}", deleted: "Yes"}
    end
  end

  private

  def event_params
    params.require(:event).permit(:city, :state, :information, :start, :end, :owner, :event_name)
  end

  def authorized?(event)
    current_user.owns_event?(event)
  end
end
