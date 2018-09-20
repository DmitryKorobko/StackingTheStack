class CreateUserToAnswerRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :user_to_answer_ratings do |t|
      t.integer :user_id
      t.integer :answer_id
      t.boolean :rating

      t.timestamps
    end
  end
end
