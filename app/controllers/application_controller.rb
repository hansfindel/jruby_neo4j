class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :current_user_name

  private

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def current_username
  	@current_username ||= current_user ? current_user.username : nil
  end
end
