class AddIndexToEventsUsers < ActiveRecord::Migration[5.2]
  def change
    add_column  :events_users, :id, :primary_key
    add_index   :events_users, :event_id
    add_index   :events_users, :user_id
  end
end
