class CommentsController < ApplicationController
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @comments = @restaurant.comments
    @comment = Comment.new(comment_params)
    if @comment.valid?
      @comment.save
      render :index
    else
      render 'restaurants/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, restaurant_id: @restaurant.id)
  end
end
