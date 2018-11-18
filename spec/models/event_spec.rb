require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:information) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
    it { should validate_presence_of(:owner) }
    it { should validate_presence_of(:event_name) }
  end

  describe 'Relationships' do
    it { should have_many(:users) }
    it { should have_many(:events_users) }
  end
end
