class Event < ApplicationRecord
  has_many :events_users
  has_many :users, through: :events_users

  before_validation {
    (self.city = self.city.to_s.downcase) &&
    (self.state = self.state.to_s.downcase)
  }

  validates_presence_of :state, :city, :information, :start, :end

end
