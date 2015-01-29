class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by username: params[:username]

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user, notice: "wb bro"
    else
      redirect_to :back, notice: "Username and/or password nope"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end