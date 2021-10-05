class Admin::CommentsController < ApplicationController
  # before_action :require_admin

  def index
    @posts = Post.all
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
end
