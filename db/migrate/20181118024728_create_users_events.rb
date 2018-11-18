class CreateUsersEvents < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :events
  end
end
