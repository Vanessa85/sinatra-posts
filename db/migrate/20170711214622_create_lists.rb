class CreateLists < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE TYPE enum_list_shared AS ENUM('PRIVATE', 'SHARED', 'PUBLIC');
    SQL
    create_table :lists do |t|
      t.string :name,   limit: 32,  null: false
      t.column :shared_with,  :enum_list_shared
      t.timestamps                  null: false
    end
    # execute "CREATE TYPE enum_list_shared AS ENUM('PRIVATE', 'SHARED', 'PUBLIC');
    # ALTER TABLE lists ADD COLUMN shared_with enum_list_shared DEFAULT 'PUBLIC';"
  end

  def down
    drop_table :lists
    execute "DROP TYPE enum_list_shared;"
  end

end
