class WorksController < ApplicationController

  def create
    @user = current_user
    @work = @user.works.create(work_params)
    redirect_to profile_path(@user)
  end
  def index
    @user = current_user
  end

  def update

  end

  def destroy
    # binding.pry
    work = Work.find(params[:id])
    work.destroy
    redirect_to edit_profile_path
  end

  private

  def work_params
    params.require(:work).permit(:name, :image)
  end

end
