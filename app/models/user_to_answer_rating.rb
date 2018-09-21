class UserToAnswerRating < ApplicationRecord
  validates :answer_id, :user_id, presence: true
  validates_uniqueness_of :user_id, scope: [:answer_id]
end
