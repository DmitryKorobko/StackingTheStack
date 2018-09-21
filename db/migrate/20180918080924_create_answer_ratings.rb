class CreateAnswerRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :answer_ratings do |t|
      t.integer :answer_id
      t.integer :rating_number, default: 0

      t.timestamps
    end
  end
end
