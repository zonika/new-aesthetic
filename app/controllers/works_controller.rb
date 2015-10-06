class WorksController < ApplicationController

  def create
    @user = current_user
    if params[:work][:image].tempfile
      colors = Miro::DominantColors.new(params[:work][:image].tempfile.path).to_hex
      if work_params[:type] != ""
        wp = work_params
        wp[:tag_list] << work_params[:type]
        wp.delete(:type)
        @work = @user.works.create(wp)
      else
        @work = @user.works.create(work_params)
      end
      @work.parse_colors(colors)
    end
    redirect_to profile_path(@user)
  end

  def index
    redirect_to profile_path(current_user)
  end

  def edit
    @user = current_user
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id])
    if work_params[:type] != ""
      wp = work_params
      wp[:tag_list] << work_params[:type]
      wp.delete(:type)
      @work.update(wp)
    else
      @work.update(work_params)
    end
    redirect_to profile_path(current_user)
  end

  def destroy
    work = Work.find(params[:id])
    work.destroy
    redirect_to edit_profile_path(current_user)
  end

  private
  def work_params
    params.require(:work).permit(:name, :image, :type, tag_list:[])
  end
end
