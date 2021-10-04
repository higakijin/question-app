class Admin::UsersController < ApplicationController
  before_action :require_admin, except: [:new, :create]

  def new
    if session[:user_id] && User.find(session[:user_id]).admin
      redirect_to admin_posts_path
    end
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password]) && user.admin
      session[:user_id] = user.id
      redirect_to admin_posts_path
    else
      render :new
    end
  end

  def index
    @users = User.all
  end

  def search
    @users = User.search(params[:keyword])
    @keyword = params[:keyword]
    render :index
  end

  def destroy
    user = User.find(params[:id])
    if user.admin == false
      user.destroy
      redirect_to admin_users_path
    else
      # adminユーザーは削除できない
      puts "削除しませんでした。"
    end
  end

  private
    
    def require_admin
      redirect_to root_path unless User.find(session[:user_id]).admin == true
    end

    def session_params
      params.require(:session).permit(:email, :password)
    end
end
