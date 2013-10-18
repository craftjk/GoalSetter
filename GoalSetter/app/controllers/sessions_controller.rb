class SessionsController < ApplicationController

  before_filter :not_logged_in, only: [:new, :create]
  before_filter :login_required, only: [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_username(params[:user][:username])

    if @user && @user.is_password?(params[:user][:password])
      login_user(@user)
      redirect_to users_url
    else
      flash[:errors] = ["Incorrect username and/or password"]
      render :new
    end
  end

  def destroy
    current_user.reset_token
    session[:token] = nil
    redirect_to new_session_url
  end

end
