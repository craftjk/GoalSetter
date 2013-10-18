module SessionsHelper
  def current_user
    User.find_by_token(session[:token])
  end

  def logged_in?
    current_user
  end

  def login_user(user)
    session[:token] = user.reset_token
  end

  def not_logged_in
    redirect_to users_url if logged_in?
  end

  def login_required
    redirect_to new_session_url unless logged_in?
  end
end
