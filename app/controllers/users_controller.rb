class UsersController < ApplicationController
  def new
    if session[:user_id]
      notice = "すでにログインしています。"
      redirect_to root_path
    end
    @user = User.new
  end

  def create
    user = User.new(user_params)
    user.save
    # ここ追加
    session[:user_id] = user.id
    redirect_to root_path
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != session[:user_id]
      redirect_to root_path
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to root_path
    else
      render edit_user_path
    end
  end

  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end
end
