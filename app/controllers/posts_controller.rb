class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    if session[:user_id]
      post.user_id = session[:user_id]
    else
      post.user_id = 0
    end
    post.save
    redirect_to posts_path
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = Comment.where(post_id: @post.id)
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user_id != session[:user_id]
      redirect_to post_path(@post)
    end
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def solved_button
    @post = Post.find(params[:id])
    @post.solved = true
    @post.save
    render :show
  end

  private

    def post_params
      params.require(:post).permit(:title, :body)
    end

end
