require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:information) }
    it { should validate_presence_of(:start) }
    it { should validate_presence_of(:end) }
  end
end
