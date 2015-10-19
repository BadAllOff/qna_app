class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :role_sid
      t.string :role_title
      t.string :role_description

      t.timestamps null: false
    end
  end
end
