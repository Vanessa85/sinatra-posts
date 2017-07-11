class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :name,   limit:128,    null: false
      t.text :description
      t.timestamps                    null: false
    end
    add_reference :posts, :users, foreign_key: true
  end
end
