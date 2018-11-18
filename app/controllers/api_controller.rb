class ApiController < ActionController::API
  include Knock::Authenticable

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from PlanItChange::Error::UserIsNotAdmin, with: :render_error_response

  protected

  def current_user
    @current_user ||= begin
      Knock::AuthToken.new(token: token).entity_for(User)
    rescue Knock.not_found_exception_class, JWT::DecodeError
      nil
    end
  end

  def authorize_as_admin
    raise PlanItChange::Error::UserIsNotAdmin.new unless current_user.is_admin?
  end

  def render_unprocessable_entity_response(exception)
    render json: {
      message: "Validation Failed",
      errors: ValidationErrorsSerializer.new(exception.record).serialize
      }, status: :unprocessable_entity
  end

  def render_not_found_response
    render json: { message: "Not found", code: "not_found"}, status: :not_found
  end

  def render_error_response(exception)
    render json: { message: exception.message, code: exception.code}, status: exception.http_status
  end
end
