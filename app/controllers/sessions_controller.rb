class SessionsController < ApplicationController
  before_action :forbid_log_in_user, only: [:new, :create]
  before_action :logged_in_user, only: [:destroy]

  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      log_in user
      flash[:success] = "ログインしました"
      redirect_to_or posts_path
    else
      @error_message = "ユーザー名またはパスワードが間違っています"
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "ログアウトしました"
    redirect_to root_url
  end
end
