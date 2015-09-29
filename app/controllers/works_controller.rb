class WorksController < ApplicationController

  def create
    @user = current_user
    @work = @user.works.create(work_params)
    redirect_to index
  end
  def index
    @user = current_user
  end

  private

  def work_params
    params.require(:work).permit(:name, :image)
  end

end
