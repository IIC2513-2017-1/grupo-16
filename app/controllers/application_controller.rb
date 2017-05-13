class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  protected

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = session.key?(:user_id) && User.find(session[:user_id])
  end
end
