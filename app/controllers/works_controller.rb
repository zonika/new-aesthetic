class WorksController < ApplicationController

  def create
    @user = current_user
  end
  def index
    @user = current_user
  end

end
