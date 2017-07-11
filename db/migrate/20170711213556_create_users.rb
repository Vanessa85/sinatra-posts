class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name,     limit: 32,  null: false, unique: true
      t.string :password, limit: 32,  null: false
      t.timestamps                    null: false
    end
  end
end
