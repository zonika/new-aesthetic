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

  # def search
  #   @users = User.search(params[:query])
  #   render 'search_results'
  # end

  def collection
  end

  def add_piece
    unless current_user.id.to_s == params[:curator]
      redirect_to '/'
    else
      CuratorWork.create(curator_id: params[:curator].to_i, piece_id: params[:piece].to_i)
      render 'collection'
    end
  end

  def remove_piece
    unless current_user.id.to_s == params[:curator]
      redirect_to '/'
    else
      relation = CuratorWork.where(curator_id: current_user.id, piece_id: params[:piece].to_i)
      relation.first.destroy
      render 'collection'
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:masterpiece,:id,:artist_statement,:zip,:website)
  end

end
