class ApiController < ActionController::API
  include Knock::Authenticable

  protected

  def authorize_as_admin
    render status: 401 unless !current_user.nil? && current_user.is_admin?
  end


end