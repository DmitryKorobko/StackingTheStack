class AddUserToQuestionAndToAnswer < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :user_id, :integer
    add_index :questions, :user_id
    add_column :answers, :user_id, :integer
    add_index :answers, :user_id
  end
end
