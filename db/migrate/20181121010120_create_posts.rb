class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references  :user
      t.text        :body

      t.timestamps
    end
  end
end