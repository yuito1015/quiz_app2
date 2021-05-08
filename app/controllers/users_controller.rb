class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
    @comments = @user.comment_posts.distinct.paginate(page: params[:page])
    @likes = @user.liked_posts.paginate(page: params[:page])
    @follows = @user.following.paginate(page: params[:page])
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
    @user.name = params[:user][:name]
    @user.password = params[:user][:password]
    if params[:user][:image_name]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:user][:image_name]
      File.binwrite("public/icons/#{@user.image_name}", image.read)
    end
    if @user.save
      flash[:success] = "ユーザー情報を編集しました"
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "アカウントを削除しました"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render "show_follow"
  end

  private

  def user_params
    params.require(:user).permit(:name, :image_name, :password)
  end

  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      flash[:danger] = "権限がありません"
      redirect_to(root_url)
    end
  end

  def admin_user
    unless current_user.admin?
      flash[:danger] = "権限がありません"
      redirect_to(root_url)
    end
  end
end
