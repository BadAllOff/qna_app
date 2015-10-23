class ChangeAttachmentableColumnsInAttachments < ActiveRecord::Migration
  def up
    rename_column :attachments, :attachmentable_type, :attachable_type
    rename_column :attachments, :attachmentable_id, :attachable_id
  end

  def down
    rename_column :attachments, :attachable_type, :attachmentable_type
    rename_column :attachments, :attachable_id, :attachmentable_id
  end
end
