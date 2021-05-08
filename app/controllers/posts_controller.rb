class PostsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :store_referrer, only: [:edit]

  def index
    @posts = Post.paginate(page: params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @comment = current_user.comments.build
    @comments = @post.comments.paginate(page: params[:page])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿を作成しました"
      redirect_to posts_url
    else
      render "new"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "投稿を編集しました"
      redirect_back_or(@post.user)
    else
      render "edit"
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "投稿を削除しました"
    if URI(request.referer).path == post_path
      redirect_to posts_url
    else
      redirect_to request.referer || posts_url
    end
  end

  private

  def post_params
    params.require(:post).permit(:question, :answer)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    if @post.nil?
      flash[:danger] = "権限がありません"
      redirect_to posts_url
    end
  end
end
