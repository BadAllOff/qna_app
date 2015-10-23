class ChangeIndexesOfAttachmentsTable < ActiveRecord::Migration
  def up
    remove_index  :attachments, :attachable_type
    remove_index  :attachments, :attachable_id

    add_index :attachments, [:attachable_id, :attachable_type]
  end

  def down
    remove_index :attachments, [:attachable_id, :attachable_type]

    add_index  :attachments, :attachable_type
    add_index  :attachments, :attachable_id
  end
end
