class PostsController < ApplicationController
  before_action :require_login, only: [:new]
  before_action :post_find, only: [:show, :edit, :update, :destroy, :solved_button]

  def index
    @posts = Post.page(params[:page]).per(10)
    @path = "/search"
  end

  def search
    @posts = Post.search(params[:keyword])
    @posts = @posts.page(params[:page]).per(10)
    @keyword = params[:keyword]
    render :index
  end

  def search_unsolved
    @posts = Post.search(params[:keyword]).where(solved: false)
    @posts = @posts.page(params[:page]).per(10)
    @keyword = params[:keyword]
    render :index
  end

  def search_solved
    @posts = Post.search(params[:keyword]).where(solved: true)
    @posts = @posts.page(params[:page]).per(10)
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
      User.select {|user| user.id != @post.user_id }.each do |send_user|
        SampleMailer.alert_when_posted(send_user, @post).deliver
      end
      flash[:message] = "質問をしました。回答を待ちましょう！"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = Comment.where(post_id: @post.id)
  end

  def edit
    if @post.user_id != session[:user_id]
      redirect_to post_path(@post)
    end
  end

  def update
    if  @post.update(post_params)
      flash[:posted] = "編集しました"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  def solved_button
    @post.solved = true
    @post.save
    redirect_to root_path
  end

  def unsolved
    @posts = Post.where(solved: false)
    @posts = @posts.page(params[:page]).per(10)
    @path = "/unsolved/search"
    render :index
  end

  def solved
    @posts = Post.where(solved: true)
    @posts = @posts.page(params[:page]).per(10)
    @path = "/solved/search"
    render :index
  end

  private

    def post_params
      params.require(:post).permit(:title, :body)
    end

    def require_login
      redirect_to login_path unless session[:user_id]
    end

    def post_find
      @post = Post.find(params[:id])
    end
end
