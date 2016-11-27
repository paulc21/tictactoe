class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_#{params[:game_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def play(data)
    # broadcast here
  end
end
