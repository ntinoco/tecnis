class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  def current_user
    # Note: we want to use "find_by_id" because it's OK to return a nil.
    # If we were to use User.find, it would throw an exception if the user can't be found.
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]

  end

  rescue_from CanCan::AccessDenied do |exception|
     flash[:error] = "Acceso degado."
     redirect_to root_url
  end

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception,                            :with => :render_error
    rescue_from ActiveRecord::RecordNotFound,         :with => :render_not_found
    rescue_from ActionController::RoutingError,       :with => :render_not_found
    rescue_from ActionController::UnknownController,  :with => :render_not_found
    rescue_from ActionController::UnknownAction,      :with => :render_not_found
  end

  private

  private
    def render_not_found(exception)
     render :template => "/error/404.html.erb", :status => 404
    end
  
    def render_error(exception)
      render :template => "/error/500.html.erb", :status => 500 
    end
end
