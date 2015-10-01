class HomeController < ApplicationController
  def index
    render :layout => false
  end

  def about
    render :layout => false
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end
