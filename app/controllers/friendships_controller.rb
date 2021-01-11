class FriendshipsController < ApplicationController

  def create
    @friendship = Friendship.new(friendship_params)

    if @friendship.save
      flash[:notice] = 'Request sent'
    else
      flash[:alert] = 'No success'
    end
    redirect_to users_path
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.alive = true

    if @friendship.save
      flash[:notice] = 'Accepted'
    else
      flash[:alert] = 'No success'
    end
    redirect_to users_path
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_to users_path
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :alive)
  end
end
