class ProfilesController < ApplicationController
  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to profile_path(@user)
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    current_user.update(user_params)
    redirect_to profile_path
  end

  def search
    @users = User.search(params[:query])
    render 'search_results'
  end

  private
  def user_params
    params.require(:user).permit(:masterpiece,:id,:artist_statement,:zip,:website)
  end

end
