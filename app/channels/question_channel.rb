class QuestionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "question_channel_#{params[:room]}"
  end

  def receive(data)
    ActionCable.server.broadcast("question_channel_#{params[:room]}", data)
  end

  def unsubscribed
  end
end