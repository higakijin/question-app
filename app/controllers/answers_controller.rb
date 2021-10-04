class AnswersController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    comment.post_id = params[:post_id]
    if session[:user_id]
      comment.user_id = session[:user_id]
      comment.save
      redirect_to post_path(params[:post_id])
    end
  end

  private
  
    def comment_params
      params.require(:comment).permit(:body)
    end
end
