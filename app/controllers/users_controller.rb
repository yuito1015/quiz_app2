class UsersController < ApplicationController
  before_action :forbid_logged_in_user, only: [:new, :create]
  before_action :not_logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
    @comments = @user.ordered_comment_posts.page(params[:page])
    @likes = @user.ordered_liked_posts.page(params[:page])
    @follows = @user.ordered_following.page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ユーザー登録が完了しました"
      redirect_to @user
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:image_name]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:user][:image_name]
      File.binwrite("public/icons/#{@user.image_name}", image.read)
    end
    if @user.update(user_params)
      flash[:success] = "ユーザー情報を編集しました"
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "アカウントを削除しました"
    if current_user && current_user.admin?
      redirect_to users_url
    else
      log_out
      redirect_to root_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :image_name, :password)
  end

  def correct_user
    @user = User.find(params[:id])
    if !current_user?(@user) && !current_user.admin?
      flash[:danger] = "権限がありません"
      redirect_to(root_url)
    end
  end
end
