class AddOwnerToEvents < ActiveRecord::Migration[5.2]
  def change
    change_table :events do |t|
      t.string :owner
    end
  end
end
