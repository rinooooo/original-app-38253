class RestaurantsController < ApplicationController
  before_action :authenticate_user!, expect: [:index]

  def index
    @restaurants = Restaurant.includes(:user)
    @tags = Tag.includes(:restaurants)
  end

  def new
    @restaurant_form = RestaurantForm.new
  end

  def create
    @restaurant_form = RestaurantForm.new(restaurant_form_params)
    if @restaurant_form.valid?
      @restaurant_form.save
      redirect_to root_path
    else
      render :new
    end
  end

  def search
    @restaurants = Restaurant.search(params[:keyword])
    @tags = Tag.includes(:restaurants)
  end

  private
  def restaurant_form_params
    params.require(:restaurant_form).permit(:shop_name, :address, :category_id, :phone_number, :url, :image, :tag_name).merge(user_id: current_user.id)
  end
end

