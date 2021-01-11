class LikesController < ApplicationController
  def create
    @like = Like.new(like_params)

    if @like.save
      flash[:notice] = 'Like it'
    else
      flash[:alert] = 'Uh oh, sth wrong'
    end
    redirect_to root_path
  end

  def destroy
    @like = Like.find(params[:id])

    @like.destroy
    flash[:notice] = 'Like taken back'
    redirect_to root_path
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :post_id)
  end
end
