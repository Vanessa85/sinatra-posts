class AddForeignKeyToPosts < ActiveRecord::Migration[5.1]
  def change
    change_column_null :posts, :user_id, false
    add_reference :posts, :list, foreign_key: true, null: false
  end
end
