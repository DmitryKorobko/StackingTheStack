module RatingHelper
  def self.update_rating(answer_id, user_id, rating)
    @rating = UserToAnswerRating.where(answer_id: answer_id, user_id: user_id).first_or_initialize
    @rating.rating = rating
    @rating.save

    UserToAnswerRating.where(answer_id: answer_id, rating: true).count - UserToAnswerRating.where(answer_id: answer_id, rating: false).count
  end
end
