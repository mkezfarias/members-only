class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      flash[:success] = 'You signed up successfully'
      log_in user
      remember user
      redirect_to root_path
    else
      flash.now[:danger] = 'Try Again'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
