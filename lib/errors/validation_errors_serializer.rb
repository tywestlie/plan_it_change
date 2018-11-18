# This class is the parent serializer class for any errors thrown. This will be included in all of
# the controllers in order to catch and serialize any errors. It utilizes the individual
# error serializer class located at /lib/errors.

class ValidationErrorsSerializer
  attr_reader :record

  def initialize(record)
    @record = record
  end

  def serialize
    record.errors.details.map do |field, details|
      details.map do |error_details|
        ValidationErrorSerializer.new(record, field, error_details).serialize
      end
    end.flatten
  end
end
