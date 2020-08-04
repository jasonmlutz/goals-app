class UsersController < ApplicationController
  def index
    @users = User.all
    render :index
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user
      render :show
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
