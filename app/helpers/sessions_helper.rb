module SessionsHelper
  include PostsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def current_user?(user)
    user && user == current_user
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
    delete_session_tag
  end

  def logged_in?
    !current_user.nil?
  end

  def forbid_logged_in_user
    if logged_in?
      flash[:danger] = "すでにログインしています"
      redirect_to posts_path
    end
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def not_logged_in_user
    if !logged_in?
      store_location
      flash[:danger] = "ログインが必要です"
      redirect_to login_url
    end
  end

  def redirect_to_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_referrer
    session[:referrer_url] = request.referer
  end

  def redirect_back_or(default)
    redirect_to(session[:referrer_url] || default)
    session.delete(:referrer_url)
  end

  def store_session_tag
    tags.keys.each { |s| session[s] = params[:post][s] if params[:post][s] }
  end

  def delete_session_tag
    tags.keys.each { |s| session.delete(s) if session[s] }
  end
end
