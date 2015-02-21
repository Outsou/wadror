class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by username: params[:username]

    if user && user.authenticate(params[:password])
      if user.banned?
        redirect_to :back, notice: 'Your account is frozen, plz contact admin'
      else
        session[:user_id] = user.id
        redirect_to user, notice: "wb bro"
      end
    else
      redirect_to :back, notice: "Username and/or password nope"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end