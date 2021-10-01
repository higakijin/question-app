class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    user.save
    # ここ追加
    session[:user_id] = user.id
    redirect_to posts_path
  end

  def index
    @users = User.all
  end

  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
