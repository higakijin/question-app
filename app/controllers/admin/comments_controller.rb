class Admin::CommentsController < ApplicationController
  before_action :require_admin
  
  def index
    @posts = Post.page(params[:page]).per(30)
  end

  def search
    comments = Comment.search(params[:keyword])
    @keyword = params[:keyword]
    @posts = []
    comments.each do |com|
      @posts.push Post.find(com.post_id)
    end
    @posts.uniq
    
    render :index
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to admin_comments_path
  end

  private

    def require_admin
      redirect_to root_path unless User.find(session[:user_id]).admin == true
    end
end
