class GameChannel < ApplicationCable::Channel
  def subscribed
    game = Game.find_by_id(1)
    stream_for game
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def play(data)
    puts data.to_json
    # lookup the game
    game = Game.where(id: data["game"], x_player: current_user).last
    unless game.blank?
      puts game.to_json
      # make the player's move
      game.play!(data["cell"].to_i,"X")
      # if this is a CPU game, make the CPU move
      # broadcast here
    else
      puts "game #{data["game"]} not found"
    end
  end
end
