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

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def search
  end

  def search_results
    @results = PgSearch.multisearch(params[:query])
  end
    

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
