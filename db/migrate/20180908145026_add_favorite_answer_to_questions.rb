class AddFavoriteAnswerToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :favorite_answer, :integer, default: nil
  end
end
