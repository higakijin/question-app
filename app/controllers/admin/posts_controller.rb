class Admin::PostsController < ApplicationController
  before_action :require_admin
  
  def index
    @posts = Post.all
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end

  private
    
    def require_admin
      redirect_to posts_path unless User.find(session[:user_id]).admin == true
    end
end
