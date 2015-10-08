class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound do
  flash[:warning] = 'Resource not found.'
  redirect_to request.referer || path
  end

  def redirect_back_or(path)
    redirect_to request.referer || path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password, :password_confirmation, :artist ) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, :zip, :latitude, :longitude, :image ) }
  end

  # handle sign in and sign up redirects

  def after_sign_in_path_for(resource)
    #eventually replace with feed
    profile_path(resource)
  end

  def after_sign_up_path_for(resource)
    #eventually replace with feed
    profile_path(resource)
  end

  def after_update_path_for(resource)
     profile_path(resource)
  end

end
