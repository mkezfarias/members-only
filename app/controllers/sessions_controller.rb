class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      log_in user
      remember user
    end
  end
  
  def delete
    log_out if logged_in?
  end
  
  private
  
  def session_params
    params.require(:session).permit(:email,:password)
  end
  
end
