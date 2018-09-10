class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:edit, :show, :update, :destroy, :favorite]

  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.build
    @answer.attachments.build
    @favorite_answer = @question.favorite_answer.nil? ? nil : @question.answers.find(@question.favorite_answer)
  end

  def new
    @question = Question.new
    @question.attachments.build
  end

  def edit
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      flash[:notice] = 'Your question successfully created.'
      redirect_to @question
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path
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

  def question_params
    params.require(:question).permit(:title, :body, :user_id, :favorite_answer, attachments_attributes: [:file])
  end
end
