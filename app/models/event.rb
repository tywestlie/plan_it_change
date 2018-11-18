class Event < ApplicationRecord
  has_many :events_users
  has_many :users, through: :events_users

  before_validation {
    (self.city = self.city.to_s.downcase) &&
    (self.state = self.state.to_s.downcase) &&
    (self.owner = self.owner.to_s.downcase)
  }

  validates_presence_of :state, :city, :information, :start_time, :end_time, :owner, :event_name

  def find_events_by_city_and_state(city, state)
    where(city: "#{city}", state: "#{state}").order(start: :desc)
  end
end
