class AddQuestionIdToAttachment < ActiveRecord::Migration
  def up
    add_column :attachments, :question_id, :integer
    add_index :attachments, :question_id
  end

  def down
    remove_index :attachments, :question_id
    remove_column :attachments, :question_id, :integer
  end
end
