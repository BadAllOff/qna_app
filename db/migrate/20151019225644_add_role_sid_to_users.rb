class AddRoleSidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role_sid, :string, default: 'vizitor'
  end
end
