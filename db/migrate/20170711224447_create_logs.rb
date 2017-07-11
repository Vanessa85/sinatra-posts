class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.string :log_line,   limit: 256, null: false
      t.timestamps  null: false
    end
    add_reference :logs, :users, foreign_key: true, null: false
    add_reference :logs, :lists, foreign_key: true, null: false
  end
end
