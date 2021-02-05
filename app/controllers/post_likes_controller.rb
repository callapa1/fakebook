class PostLikesController < ApplicationController
  def create
    @post = params[:id]
    @like = current_user.like(@post)
    if @like.save
      redirect_to posts_path
    end
  end

  def destroy
    @post = params[:id].to_i
    @like = Like.where(liker_id: current_user, liked_id: @post)
    @like.first.delete

    redirect_to posts_path
  end
end