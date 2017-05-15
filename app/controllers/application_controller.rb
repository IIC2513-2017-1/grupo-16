class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :current_controller?

  protected

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = session.key?(:user_id) && User.find(session[:user_id])
  end

  #Got this idea from http://stackoverflow.com/questions/1203892/how-can-i-find-out-the-current-route-in-rails
  def current_controller?(names)
    names.include?(controller_name)
  end
end
