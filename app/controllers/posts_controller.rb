class PostsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @posts = Post.all.order('created_at DESC')
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @user = current_user
    @post = @user.posts.create(post_params)
    redirect_to root_path
  end

  private
  
  def post_params
    params.require(:post).permit(:content, :user_id)
  end
end