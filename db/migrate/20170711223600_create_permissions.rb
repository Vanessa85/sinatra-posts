class CreatePermissions < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE TYPE enum_permission_level AS ENUM('READ_ONLY', 'READ_WRITE');
    SQL
    create_table :permissions do |t|
      t.column :permission_level, :enum_permission_level, null: false, default: 'READ_ONLY'
      t.timestamps  null: false
    end

    add_reference :permissions, :user, foreign_key: true, null: false
    add_reference :permissions, :list, foreign_key: true, null: false

  end

  def down
    drop_table :permissions
    execute <<-SQL
      DROP TYPE enum_permission_level;
    SQL
  end

end
