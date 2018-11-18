class ChangeEvents < ActiveRecord::Migration[5.2]
  def change
    change_table :events do |t|
      t.rename :start, :start_time
      t.rename :end, :end_time
      t.rename :name, :event_name
    end
  end
end
