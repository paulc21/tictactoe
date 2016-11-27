class GamesController < ApplicationController

  def index
  end

  def create
    game = Game.create(x_player:cookies.signed[:username])
    redirect_to game_path(game.id)
  end

  def show
    @game = Game.find_by_id(params[:id])
    if @game.blank?
      flash[:error] = "No game found"
      redirect_to games_path and return
    end
    unless @game.x_player == cookies.signed[:username]
      flash[:error] = "Not your game"
      redirect_to games_path and return
    end

    # play the game
  end

end
