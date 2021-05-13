class PostsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :store_referrer, only: [:edit]

  def index
    @search = search_params
    @posts = Post.search(@search).page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @comment = current_user.comments.build
    @comments = @post.comments.page(params[:page])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    rewrite_answer
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿を作成しました"
      redirect_to posts_url
    else
      set_answer
      render "new"
    end
  end

  def edit
    @post = Post.find(params[:id])
    if @post.kind == "自由記述"
      @answer = @post.answer
    else
      @options = @post.answer.split("　")
    end
    @ids = @options.shift.split(",") if @post.kind == "一問多答"
  end

  def update
    @post = Post.find(params[:id])
    rewrite_answer
    if @post.update(post_params)
      flash[:success] = "投稿を編集しました"
      redirect_back_or(@post.user)
    else
      set_answer
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
    params.require(:post).permit(:question, :answer, :kind, :media, :series, :belong,
                                 :group, :geography, :category)
  end

  def search_params
    params.fetch(:search, {}).permit(:kind, :media, :series, :belong, :group, :geography, :category)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    if @post.nil?
      flash[:danger] = "権限がありません"
      redirect_to posts_url
    end
  end

  def rewrite_answer
    params[:options].unshift(params[:ids].join(",")) if params[:ids]
    params[:post][:answer] = params[:options].join("　") if params[:options]
  end

  def set_answer
    @answer = params[:post][:answer] if params[:post][:kind] == "自由記述"
    if params[:options]
      params[:post][:kind] == "一問多答" ? @options = params[:options].drop(1) : @options = params[:options]
    end
    @ids = params[:ids] if params[:ids]
  end
end
