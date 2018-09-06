class AnswersController < ApplicationController
  before_action :load_question, only: [:create]
  before_action :load_answer, only: [:update]

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

  private

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end
end
