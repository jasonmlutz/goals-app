class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    # fail
    @user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    if @user
      login!(@user)
      redirect_to goals_url
    else
      flash[:errors] = ['Invalid credentials']
      render :new
    end
  end

  def destroy
    logout!
    render :new
  end
end
