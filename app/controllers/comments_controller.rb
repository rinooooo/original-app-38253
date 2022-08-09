class CommentsController < ApplicationController
  
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @comment = @restaurant.comments.new(comment_params)
    @comment.save
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :nickname).merge(user_id: current_user.id, restaurant_id: @restaurant.id)
  end

end
