class WorksController < ApplicationController

  def create
    @user = current_user
    wp = work_params
    if work_params[:type] != ""
      wp[:tag_list] << work_params[:type]
      wp.delete(:type)
    end
    @work = @user.works.new(wp)
    if @work.save
      colors = Miro::DominantColors.new(params[:work][:image].tempfile.path).to_hex
      @work.parse_colors(colors)
      if !@user.masterpiece
        @user.update(masterpiece:@work.id)
      end
      redirect_to profile_path(@user)
    else
      render 'profiles/edit'
    end
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
