class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.where(user: current_user.friends.map { |f| f.friendships.alive.eql? true })
                 .or(Post.where(user_id: current_user.inverse_friendships.map { |f| f.alive.eql? true }))
                 .or(Post.where(user: current_user))
                 .order(created_at: :desc)
  end
end
