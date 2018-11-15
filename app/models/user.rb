class User < ApplicationRecord
  has_secure_password

  validates_length_of       :password, maximum: 72, minimum: 6, allow_nil: false, allow_blank: false
  validates_confirmation_of :password, allow_nil: false, allow_blank: false

  before_validation {
    (self.username = self.username.to_s.downcase) && 
    (self.first_name = self.first_name.to_s.downcase) && 
    (self.last_name = self.last_name.to_s.downcase) &&
    (self.city = self.city.to_s.downcase) &&
    (self.state = self.state.to_s.downcase)
  }

  validates_presence_of     :username, :first_name, :last_name, :city, :state
  validates_uniqueness_of   :username

  def can_modify_user?(user_id)
    role == 'admin' || id.to_s == user_id.to_s
  end

  def is_admin?
    role == 'admin'
  end
end
