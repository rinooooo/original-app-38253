class TagsController < ApplicationController
  before_action :authenticate_user!, expect: [:show]


  def show
    @tags = Tag.includes(:restaurants)
    @tag = Tag.find(params[:id])
    @restaurants = @tag.restaurants
    @restaurant_all = Restaurant.includes(:user)
    @restaurant_form = RestaurantForm.new
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to root_path
  end

end
