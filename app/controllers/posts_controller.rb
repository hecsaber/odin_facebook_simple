class PostsController < ApplicationController

  def index
    @posts = Post.where(user: current_user.friends.alive)
                 .or(Post.where(user_id: current_user.inverse_friends.alive))
                 .or(Post.where(user: current_user))
                 .order(created_at: :desc)
    @comment = current_user.comments.build
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:notice] = 'Post created'
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:notice] = 'Post updated'
      redirect_to root_path
    else
      render :new
    end
  end

  private

  helper_method :like_finder

  def like_finder(user, post)
    Like.find_by(user: user, post: post)
  end

  def post_params
    params.require(:post).permit(:description)
  end
end
