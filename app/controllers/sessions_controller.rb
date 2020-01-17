class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      flash[:success] = "You're logged in!"
      log_in user
      remember user
      redirect_to root_path
    else
      flash.now[:danger] = 'Try again'
      render :new
    end
  end

  def delete
    log_out if logged_in?
    flash[:success] = "You're logged out"
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
