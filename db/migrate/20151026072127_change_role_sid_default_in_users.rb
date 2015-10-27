class ChangeRoleSidDefaultInUsers < ActiveRecord::Migration
  def up
    change_column_default :users, :role_sid, :default => nil
  end

  def down
    change_column_default :users, :role_sid, :default => 'vizitor'
  end
end
