class RemakeAttacmentsIndexes < ActiveRecord::Migration[5.2]
  def change
    remove_index :attachments, :attachmentable_id
    remove_index :attachments, :attachmentable_type
    add_index :attachments, [:attachmentable_id, :attachmentable_type]
  end
end
