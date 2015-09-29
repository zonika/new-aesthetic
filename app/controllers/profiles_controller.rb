class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def show
    @user = current_user
  end

  def update
    current_user.update(user_params)
    redirect_to show
  end

  private
  def user_params
    params.require(:user).permit(:masterpiece)
  end

end
