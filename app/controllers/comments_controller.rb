class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_parent

  respond_to :js

  def create
    respond_with(@comment = @parent.comments.create(comment_params))
  end

  private

  def load_parent
    @parent = Answer.find(params[:answer_id]) if params[:answer_id]
    @parent ||= Question.find(params[:question_id])
  end

  def comment_params
    params.require(:comment).permit(:message)
  end
end