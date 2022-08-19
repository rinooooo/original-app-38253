class CommentsController < ApplicationController
  before_action :authenticate_user!

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

  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    @comment = Comment.find_by(restaurant_id: params[:restaurant_id], id: params[:id])
    @comment.destroy
    @comments = @restaurant.comments
    render :index
  end

  private

  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, restaurant_id: @restaurant.id)
  end
end
