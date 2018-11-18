class AddIndexesToEvents < ActiveRecord::Migration[5.2]
  def change
    add_index :events, :city
    add_index :events, :state
  end
end
