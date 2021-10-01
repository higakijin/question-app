class SessionsController < ApplicationController
  def new
  end

  def create
    binding.pry
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to posts_path
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to posts_path
  end

  private
    
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
