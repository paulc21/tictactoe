module Cpu
  class Player

    # This is an attempted conversion of a
    # JavaScript algorithm I found online at
    # https://mostafa-samir.github.io/Tic-Tac-Toe-AI/
    def minimax(game)
      result = game.result
      
      if result
        # game is over
        return game.cpu_score
      else
        state_score = -1000
        
        # Get all possible actions and their scores
        actions = []
        game.empty_spaces.each do |e|
          action = Cpu::Action.new(e)
          _game = action.play(game)
          action.score = minimax(_game)
          actions.push(action)
        end

        actions.each do |a|
          state_score = a.score if a.score > state_score
        end
        return state_score
      end
    end
  end

  class Action
    attr_accessor :index, :score

    def initialize(index)
      @index = index
    end

    def play(game)
        _game = Game.new(state: game.state)
        _game.play(@index,_game.turn)
        return _game
    end
  end
end
