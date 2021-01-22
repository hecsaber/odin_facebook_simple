class UsersController < ApplicationController
  def index
    @users = User.where('id != ?', current_user)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = 'OK'
    end

    redirect_to root_path
  end

  private

  helper_method :friendship_finder

  def friendship_finder(current, user)
    Friendship.find_by(friend_id: current.id, user_id: user.id)
  end

  def user_params
    params.require(:user).permit(:name, :profile, :avatar)
  end
end
