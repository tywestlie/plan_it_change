require 'rails_helper'

RSpec.describe EventsUser, type: :model do
  describe 'Relationships' do
    it { should belong_to(:event) }
    it { should belong_to(:user) }
  end
end
