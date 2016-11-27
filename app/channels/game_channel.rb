class GameChannel < ApplicationCable::Channel
  def subscribed
    puts params
    game = Game.find_by_id(params[:id])
    stream_for game
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def play(data)
    begin
      # lookup the game
      game = Game.where(id: data["game"], x_player: current_user).last
      unless game.blank?
        puts game.to_json
        # make the player's move
        game.play!(data["cell"].to_i,"X")
        # Check for a result

        unless game.result
          # make the CPU move

          cpu = Cpu::Player.new
          actions = []
          game.empty_spaces.each do |e|
            action = Cpu::Action.new(e)
            _game = action.play(game)
            action.score = cpu.minimax(_game)
            actions.push(action)
          end
          best = actions.sort{|a,b| a.score <=> b.score }.first
          game.play!(best.index,"O")
        end
        puts "#{best.index} -- #{game.state}"
        ActionCable.server.broadcast(game, state: game.state )
      else
        puts "game #{data["game"]} not found"
      end
    rescue Exception => e
      ActionCable.server.broadcast(game, error: e.message )
    end
  end
end
