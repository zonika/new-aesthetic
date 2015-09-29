class HomeController < ApplicationController
  def index
    render :layout => false
  end

  def about
    render :layout => false
  end
end
