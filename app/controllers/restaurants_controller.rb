class RestaurantsController < ApplicationController
  before_action :authenticate_user!, expect: [:index]

  def index
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:shop_name, :address, :category_id, :phone_number, :url).merge(user_id: current_user.id)
  end
end

