class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:edit, :show, :update, :destroy, :favorite]
  before_action :build_answer, only: :show

  respond_to :js

  authorize_resource

  def index
    respond_with(@questions = Question.all)
  end

  def show
    respond_with @question
  end

  def new
    respond_with (@question = Question.new)
  end

  def edit; end

  def create
    respond_with(@question = Question.create(question_params))
  end

  def update
    @question.update(question_params)
    respond_with @question
  end

  def destroy
    respond_with(@question.destroy)
  end

  def favorite
    @question.update(favorite_answer: params[:favorite_answer])
    flash[:notice] = 'Favorite answer is changed.'
    redirect_to @question
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def build_answer
    @answer = @question.answers.build
    @favorite_answer = @question.favorite_answer.nil? ? nil : @question.answers.find(@question.favorite_answer)
  end

  def question_params
    params.require(:question).permit(:title, :body, :user_id, :favorite_answer, attachments_attributes: [:file])
  end
end
