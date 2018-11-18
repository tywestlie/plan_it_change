# This is the individual error serializer, it takes in the errors as they are thrown and serializes
# them to be a bit more readable. Here we take advantage of the I18n methods in order to 
# put the error message, the resource that caused it, and the status code into a more readable form.

class ValidationErrorSerializer
  def initialize(record, field, details)
    @record = record
    @field = field
    @details = details
  end

  def serialize
    {
      resource: resource,
      field:    field,
      code:     code
    }
  end

  private

  def resource
    I18n.t(
      underscored_resource_name,
      scope: [:resources],
      locale: :api,
      default: @record.class.to_s
    )
  end

  def field
    I18n.t(
      @field,
      scope: [:fields, underscored_resource_name],
      locale: :api,
      default: @field.to_s
    )
  end

  def code
    I18n.t(
      @details[:error],
      scope: %i[errors codes],
      locale: :api,
      default: @details[:error].to_s
    )
  end

  def underscored_resource_name
    @record.class.to_s.gsub('::', '').underscore
  end
end
