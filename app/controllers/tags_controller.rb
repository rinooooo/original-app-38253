class TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :create_searching_object, only: [:show, :search]
  before_action :find_tag, only: [:show, :destroy, :search]


  def show
    #マップ、レストランの表示レストラン（マイページ）
    @tag_restaurants = @tag.restaurants
    @restaurants = @tag_restaurants.where(user_id: current_user.id)
    #マップ、レストランの表示レストラン（シェアページ）
    @following_users = current_user.followings
    @follower_users = current_user.followers

    @relationships_restaurants = []
    @tag_restaurants = @tag.restaurants
    if @following_users.present?
      @following_users.each do |user|
        following_user_tag_restaurants = @tag_restaurants.where(user_id: user.id)
        @relationships_restaurants.concat(following_user_tag_restaurants)
      end
      @user_restaurants = @tag_restaurants.where(user_id: current_user.id)
      @relationships_restaurants.concat(@user_restaurants)
    else
      @tag_restaurants = @tag.restaurants
      @relationships_restaurants = @tag_restaurants.where(user_id: current_user.id)
    end
  end

  def destroy
    @tag.destroy
    redirect_to root_path
  end

  def search
    #マップ、レストランの表示レストラン
    @restaurant_ransack = @p.result
    @restaurants_user = @restaurant_ransack.where(user_id: current_user.id)
    @restaurants_tag = @tag.restaurants
    @restaurants = @restaurants_user & @restaurants_tag
    #サイドバー
    @restaurant_all = current_user.restaurants
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

  def find_tag
    @tag = Tag.find(params[:id])
  end
end
