class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :success
  #skip_before_filter :require_login

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    #rescue ActiveRecord::RecordNotFound
  end
  helper_method :current_user
  #before_filter :require_user
  def require_user
    if current_user
      true
    else
      redirect_to '/signup', notice: "You must be logged in to access this page."
    end
  end
end
