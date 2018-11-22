require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do
  include APIHelper
  before(:each) do
    @user1 =  create(:user)
    @user2 =  create(:user)
    @event =  create(:event, owner: @user1.email, start_time: Faker::Time.between(3.days.ago, 2.days.ago).to_datetime)
    @event2 = create(:event, owner: @user2.email, start_time: Faker::Time.between(8.days.ago, 7.days.ago).to_datetime)
    @event3 = create(:event, owner: @user2.email, start_time: Faker::Time.between(10.days.ago, 9.days.ago).to_datetime)
  end

  describe "Get #show" do
    it 'should return an event when queried' do
      get :show, params: { use_route: "/api/v1/event_show/#{@event.id}", id: "#{@event.id}" }

      result = parse_json(response)

      expect(response).to have_http_status(200)
      expect(result[:city]).to eq(@event.city)
      expect(result[:state]).to eq(@event.state)
      expect(result[:event_name]).to eq(@event.event_name)
      expect(result[:owner]).to eq(@event.owner)
      expect(DateTime.parse(result[:start_time])).to eq(@event.start_time.to_s)
      expect(DateTime.parse(result[:end_time])).to eq(@event.end_time.to_s)
    end

    it 'should return an error if there is no event that matches the id' do
      get :show, params: { use_route: "/api/v1/event_show/10000", id: "10000" }

      result = parse_json(response)

      expect(response).to have_http_status(404)
      expect(result[:code]).to eq("not_found")
      expect(result[:message]).to eq("Not found")
    end
  end

  describe "Get #index" do
    it 'should return a list of events and information when queried with a city and state' do
      get :index, params: {city: "Denver", state: "CO"}

      result = parse_json(response)
      expect(response).to have_http_status(200)
      expect(result[0][:city]).to eq(@event.city)
      expect(result[0][:state]).to eq(@event.state)
      expect(result[0][:information]).to eq(@event.information)
      expect(result[0][:owner]).to eq(@event.owner)
      expect(result[1][:city]).to eq(@event2.city)
      expect(result[1][:state]).to eq(@event2.state)
      expect(result[1][:information]).to eq(@event2.information)
      expect(result[1][:owner]).to eq(@event2.owner)
      expect(result[2][:city]).to eq(@event3.city)
      expect(result[2][:state]).to eq(@event3.state)
      expect(result[2][:information]).to eq(@event3.information)
      expect(result[2][:owner]).to eq(@event3.owner)
    end

    it 'should return an error if there are no events for that area' do
      get :index, params: {city: "Los Angeles", state: "CA"}

      result = parse_json(response)

      expect(response).to have_http_status(404)
      expect(result[:code]).to eq("not_found")
      expect(result[:message]).to eq("Not found")
    end
  end

  describe "Patch #update" do
    it 'should return a successful update message if the record is updated' do
      authenticated_header(request, @user1)

      patch :update, params: {use_route: "/api/v1/event_update/#{@event.id}", id: "#{@event.id}", event: { city: "Los Angeles", state: "CA"}}

      result = parse_json(response)

      expect(response).to have_http_status(200)
      expect(result[:event]).to eq("#{@event.event_name}")
      expect(result[:updated]).to eq("Yes")
      expect(Event.find(@event.id).state).to eq("ca")
      expect(Event.find(@event.id).city).to eq("los angeles")
    end
  end
end
