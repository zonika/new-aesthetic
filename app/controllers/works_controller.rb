class WorksController < ApplicationController

  def create
    @user = current_user
    @tags = all_tags
    @work = @user.works.create(work_params)
    redirect_to profile_path(@user)
  end

  def index
    @user = current_user
  end

  def edit
    @user = current_user
    @tags = all_tags
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id])
    @work.update(work_params)
    redirect_to profile_path(current_user)
  end

  def destroy
    work = Work.find(params[:id])
    work.destroy
    redirect_to edit_profile_path(current_user)
  end

  private

  def work_params
    params.require(:work).permit(:name, :image, :tag_list)
  end

  def all_tags
    ActsAsTaggableOn::Tag.all
  end

end
