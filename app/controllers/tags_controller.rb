class TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :create_searching_object, only: [:show, :search]


  def show
    #マップ、レストランの表示レストラン
    @tag = Tag.find(params[:id])
    @tag_restaurants = @tag.restaurants
    @restaurants = @tag_restaurants.where(user_id: current_user.id)
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to root_path
  end

  def search
    #マップ、レストランの表示レストラン
    @restaurant_ransack = @p.result
    @restaurants_user = @restaurant_ransack.where(user_id: current_user.id)
    @tag = Tag.find(params[:id])
    @restaurants_tag = @tag.restaurants
    @restaurants = @restaurants_user & @restaurants_tag
    #サイドバーの（全て）
    @restaurant_all = current_user.restaurants
    #サイドバーのタグ
    @tag_array = []
    @restaurant_all.each do |restaurant|
      if restaurant.user_id == current_user.id
        tags = restaurant.tags
        tags.each do |tag|
          @tag_array.push(tag)
        end
      end
    end
    @tags = @tag_array.uniq
    #店登録のためのインスタンス生成(hiddenでいるから)
    @restaurant_form = RestaurantForm.new
  end

  private
  def create_searching_object
    @p = Restaurant.ransack(params[:q]) 
  end

end
