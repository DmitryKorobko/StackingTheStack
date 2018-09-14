class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:create, :destroy, :update]
  before_action :load_favorite, only: [:create, :destroy, :update]
  before_action :load_answer, only: [:update, :destroy]

  def create
    @answer = @question.answers.create(answer_params)

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
    redirect_to question_path(@question)
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
