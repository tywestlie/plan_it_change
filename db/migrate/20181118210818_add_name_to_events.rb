class AddNameToEvents < ActiveRecord::Migration[5.2]
  def change
    change_table :events do |t|
      t.string :name
    end
  end
end
