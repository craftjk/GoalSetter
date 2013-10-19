class UsersController < ApplicationController

  before_filter :login_required, only: [:index]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      login_user(@user)

      redirect_to users_url
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def index
    @users = User.all
    render :index
  end

end
