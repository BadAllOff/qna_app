class ConvertAttachmentToPolymorphic < ActiveRecord::Migration
  def up
    remove_index  :attachments, :question_id
    remove_column :attachments, :question_id

    add_column    :attachments, :attachmentable_id,   :integer
    add_index     :attachments, :attachmentable_id

    add_column    :attachments, :attachmentable_type, :string
    add_index     :attachments, :attachmentable_type
  end

  def down
    remove_index  :attachments, :attachmentable_type
    remove_column :attachments, :attachmentable_type
    remove_index  :attachments, :attachmentable_id
    remove_column :attachments, :attachmentable_id

    add_column    :attachments, :question_id,         :integer
    add_index     :attachments, :question_id
  end
end
