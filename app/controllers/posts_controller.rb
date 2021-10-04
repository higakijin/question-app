class PostsController < ApplicationController
  before_action :require_admin, only: [:new]

  def index
    @posts = Post.all
  end

  def search
    @posts = Post.search(params[:keyword])
    @keyword = params[:keyword]
    render :index
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = session[:user_id]
    if @post.save
      redirect_to root_path
    else
      render :new
    end
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
    redirect_to root_path
  end

  def solved_button
    @post = Post.find(params[:id])
    @post.solved = true
    @post.save
    redirect_to root_path
  end

  def unsolved
    @posts = Post.where(solved: false)
    render :index
  end

  def solved
    @posts = Post.where(solved: true)
    render :index
  end

  private

    def post_params
      params.require(:post).permit(:title, :body)
    end

    def require_admin
      redirect_to login_path unless session[:user_id]
    end
end
