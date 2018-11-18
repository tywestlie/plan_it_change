require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do
  include APIHelper
  let(:user1) { create(:user) }
  let(:user2) { create(:user)}
  let(:event) { create(:event, owner: user1.email) }
  let(:event2) { create(:event, owner: user2.email) }
  let(:event3) { create(:event, owner: user2.email) }

  describe "Get #show" do
    it 'should return an event when queried' do
      get :show, params: { use_route: "/api/v1/event_show/#{event.id}", id: "#{event.id}" }

      result = parse_json(response)

      expect(response).to have_http_status(200)
      expect(result[:city]).to eq(event.city)
      expect(result[:state]).to eq(event.state)
      expect(result[:event_name]).to eq(event.event_name)
      expect(result[:owner]).to eq(event.owner)
      expect(DateTime.parse(result[:start_time])).to eq(event.start_time.to_s)
      expect(DateTime.parse(result[:end_time])).to eq(event.end_time.to_s)
    end
  end
end
