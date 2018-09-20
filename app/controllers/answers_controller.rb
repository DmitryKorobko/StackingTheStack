class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question
  before_action :load_favorite
  before_action :load_answer, only: [:update, :destroy, :rating_up, :rating_down]

  def create
    @answer = @question.answers.create(answer_params)
    AnswerRating.create(answer_id: @answer.id)

    # respond_to do |format|
    #   if @answer.save
    #     format.js do
    #       PrivatePub.publish_to"/questions/#{@question.id}/answers", answer: @answer.to_json
    #       render nothing: true
    #     end
    #   else
    #     PrivatePub.publish_to"/questions/#{@question.id}/answers", errors: @answer.errors.full_messages
    #   end
    # end
  end

  def update
    @answer.update(answer_params)
    @question = @answer.question
  end

  def destroy
    @answer.destroy
  end

  def rating_up
    @rating = UserToAnswerRating.where(answer_id: @answer.id, user_id: current_user.id).first_or_initialize
    @rating.rating = true
    @rating.save

    @answer_rating = UserToAnswerRating.where(answer_id: @answer.id, rating: true).count - UserToAnswerRating.where(answer_id: @answer.id, rating: false).count
    @answer.answer_rating.update(rating_number: @answer_rating)

    flash[:notice] = 'Rating is added.'

    redirect_to @question
  end

  def rating_down
    @rating = UserToAnswerRating.where(answer_id: @answer.id, user_id: current_user.id).first_or_initialize
    @rating.rating = false
    @rating.save

    @answer_rating = UserToAnswerRating.where(answer_id: @answer.id, rating: true).count - UserToAnswerRating.where(answer_id: @answer.id, rating: false).count
    @answer.answer_rating.update(rating_number: @answer_rating)

    flash[:notice] = 'Rating is added.'

    redirect_to @question
  end

  private

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body, :user_id, attachments_attributes: [:file, :_destroy])
  end

  def load_favorite
    @favorite_answer = @question.favorite_answer.nil? ? nil : @question.answers.find(@question.favorite_answer)
  end
end
