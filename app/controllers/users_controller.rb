class UsersController < ApplicationController
  def index
    @users = User.where('id != ?', current_user)
  end

  def show
  end

  private

  helper_method :friendship_finder

  def friendship_finder(current, user)
    Friendship.find_by(friend_id: current.id, user_id: user.id)
  end

end
