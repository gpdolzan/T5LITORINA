class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :admin?
  
  private
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end
  
  def admin?
    logged_in? && current_user.admin?
  end
  
  def authenticate_user!
    redirect_to login_path, alert: "Você precisa estar logado para acessar esta página." unless logged_in?
  end
  
  def authenticate_admin!
    redirect_to root_path, alert: "Você não está autorizado a realizar esta ação." unless admin?
  end
end
