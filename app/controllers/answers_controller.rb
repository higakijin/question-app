class AnswersController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    if session[:user_id]
      @comment.user_id = session[:user_id]
      if @comment.save
        flash[:posted] = "回答しました。"
        redirect_to post_path(params[:post_id])

        users = []
        users.push User.find(@post.user_id)
        @post.comments.each do |com|
          users.push User.find(com.user_id)
        end
        users = users.uniq

        users.select {|user| user.id != @comment.user_id }.each do |user|
          SampleMailer.alert_when_commented(user, @post, @comment).deliver
        end
      else
        @comments = Comment.where(post_id: @post.id)
        render "posts/show"
      end
    end
  end

  private
  
    def comment_params
      params.require(:comment).permit(:body)
    end
end
