require 'test_helper'

class GameTest < ActiveSupport::TestCase
  # Turn count
  test "turn counter" do
    game = Game.new
    game.state = [" "," "," "," "," "," "," "," "," "]
    assert game.turn == "X" # X goes first
    game.state = ["X"," "," "," "," "," "," "," "," "]
    assert game.turn == "O" # O goes next
    game.state = ["X"," "," "," ","O"," "," "," "," "]
    assert game.turn == "X" # X goes next
  end

  # Win conditions
  test "row win" do
    game = Game.new
    game.state = ["X","X","X"," "," ","O"," "," ","O"]
    assert game.result == "X"
  end

  test "column win" do
    game = Game.new
    game.state = ["X","X","O"," ","X","O"," "," ","O"]
    assert game.result == "O"
  end

  test "diagonal win" do
    game = Game.new
    game.state = %w(X X O O X O X O X)
    assert game.result == "X"
  end

  test "draw" do
    game = Game.new
    game.state = %w(X X O O X X X O O)
    assert game.result == "draw"
  end

  test "no result" do
    game = Game.new
    game.state = [" "," ","X"," "," "," "," "," ","O"]
    assert game.result == false
  end
end
