class EventSerializer < ActiveModel::Serializer
  attributes :id, :state, :city, :information, :start_time, :end_time, :owner, :event_name
end
