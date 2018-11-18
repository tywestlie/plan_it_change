class ApiController < ActionController::API
  include Knock::Authenticable

  protected

  def current_user
    @current_user ||= begin
      Knock::AuthToken.new(token: token).entity_for(User)
    rescue Knock.not_found_exception_class, JWT::DecodeError
      nil
    end
  end
end