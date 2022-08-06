class GosController < ApplicationController
  before_action :authenticate_user!

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    Go.create(user_id: current_user.id, restaurant_id: params[:restaurant_id])
  end

end
