class Admin::UsersController < ApplicationController
  before_action :require_admin

  def index
    @users = User.all
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_users_path
  end

  private
    
    def require_admin
      redirect_to root_path unless User.find(session[:user_id]).admin == true
    end
end
