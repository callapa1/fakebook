class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.post_id = params[:post_id]
    @comment.user_id = current_user.id
    
    if @comment.save
      redirect_to post_path(params[:post_id])
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.delete
    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end