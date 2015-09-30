class ProfilesController < ApplicationController
  def edit
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    current_user.update(user_params)
    redirect_to edit_profile_path
  end

  def search
    @users = User.search(params[:query])
    render 'search_results'
  end

  private
  def user_params
    params.require(:user).permit(:masterpiece,:id)
  end

end
