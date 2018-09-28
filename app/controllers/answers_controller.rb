class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question
  before_action :load_favorite
  before_action :load_answer, only: [:update, :destroy, :rating_up, :rating_down]

  respond_to :js

  def create
    @answer = @question.answers.create(answer_params)
    AnswerRating.create(answer_id: @answer.id)
    respond_with @answer
  end

  def update
    @answer.update(answer_params)
    @question = @answer.question
    respond_with @answer
  end

  def destroy
    @answer.destroy
  end

  def rating_up
    @answer.answer_rating.update(rating_number: RatingHelper.update_rating(@answer.id, current_user.id, true))

    flash[:notice] = 'Rating is added.'

    redirect_to @question
  end

  def rating_down
    @answer.answer_rating.update(rating_number: RatingHelper.update_rating(@answer.id, current_user.id, false))

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
    @favorite_answer = @question.answers.find_by(id: @question.favorite_answer&.id)
  end
end
