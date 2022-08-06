class RestaurantsController < ApplicationController
  before_action :authenticate_user!, expect: [:index]
  before_action :create_searching_object, only: [:index, :search, :search_category]

  def index
    @restaurants = Restaurant.includes(:user)
    @tags = Tag.includes(:restaurants)
    @restaurant_all = @restaurants
    @restaurant_form = RestaurantForm.new
  end

  def new
    @restaurant_form = RestaurantForm.new
  end

  def create
    @restaurants = Restaurant.includes(:user)
    @restaurant_form = RestaurantForm.new(restaurant_form_params)
    respond_to do |format|
      if @restaurant_form.valid?
        @restaurant_form.save
        format.js
      else
        format.html { render :new } 
      end
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    @restaurant_form = RestaurantForm.new(shop_name: @restaurant.shop_name, address: @restaurant.address, category_id: @restaurant.category_id, phone_number: @restaurant.phone_number, url: @restaurant.url)
  end

  def update
    @restaurants = Restaurant.includes(:user)
    @restaurant = Restaurant.find(params[:id])
    @restaurant_form = RestaurantForm.new(restaurant_form_update_params)
    respond_to do |format|
      if @restaurant_form.valid?
        @restaurant_form.update
        format.js
      else
        format.html { render :edit } 
      end
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to root_path
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @restaurant_all = Restaurant.includes(:user)
    @tags = Tag.includes(:restaurants)
    @restaurant_form = RestaurantForm.new(shop_name: @restaurant.shop_name, address: @restaurant.address, category_id: @restaurant.category_id, phone_number: @restaurant.phone_number, url: @restaurant.url)
    @restaurant_form_new = RestaurantForm.new
  end


  def search
    @restaurants = Restaurant.search(params[:keyword])
    @tags = Tag.includes(:restaurants)
    @restaurant_all = Restaurant.includes(:user)
  end

  def search_category
    @restaurants = @p.result
    @tags = Tag.includes(:restaurants)
    @restaurant_all = Restaurant.includes(:user)
  end

  private
  def restaurant_form_params
    params.require(:restaurant_form).permit(:shop_name, :address, :category_id, :phone_number, :url, :image, :tag_name).merge(user_id: current_user.id)
  end

  def restaurant_form_update_params
    params.require(:restaurant_form).permit(:shop_name, :address, :category_id, :phone_number, :url, :image, :tag_name).merge(user_id: current_user.id, restaurant_id: @restaurant.id)
  end

  def create_searching_object
    @p = Restaurant.ransack(params[:q]) 
  end

 
end

