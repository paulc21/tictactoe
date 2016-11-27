class SessionsController < ApplicationController

  def new
    unless cookies.signed[:username].blank?
      flash[:success] = "You've signed in"
      redirect_to games_path and return
    end
  end

  def create
    cookies.signed[:username] = params[:session][:username]
    redirect_to games_path and return
  end

end
