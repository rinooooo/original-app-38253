class TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :create_searching_object, only: [:show, :search, :search_category]
  before_action :find_tag, only: [:show, :destroy, :search]

  def show
    # マップ、レストランの表示レストラン（マイページ）
    @tag_restaurants = @tag.restaurants
    @restaurants = @tag_restaurants.where(user_id: current_user.id)
    # マップ、レストランの表示レストラン（シェアページ）
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

  # マイページ_tag_カテゴリー検索
  def search
    # マップ、レストランの表示レストラン
    @restaurant_ransack = @p.result
    @restaurants_user = @restaurant_ransack.where(user_id: current_user.id)
    @restaurants_tag = @tag.restaurants
    @restaurants = @restaurants_user & @restaurants_tag
    # サイドバー
    @restaurant_all = current_user.restaurants
    @tag_array = []
    @restaurant_all.each do |restaurant|
      next unless restaurant.user_id == current_user.id

      tags = restaurant.tags
      tags.each do |tag|
        @tag_array.push(tag)
      end
    end
    @tags = @tag_array.uniq
    # 店登録のためのインスタンス生成(hiddenでいるから)
    @restaurant_form = RestaurantForm.new
    @following_users = current_user.followings
    @follower_users = current_user.followers
  end

  # シェアページ_tag_カテゴリー検索
  def search_category
    # （サイドバー）
    @following_users = current_user.followings
    @follower_users = current_user.followers
    @restaurant_all = []
    if @following_users.present?
      @following_users.each do |user|
        following_user_restaurants = Restaurant.where(user_id: user.id)
        @restaurant_all.concat(following_user_restaurants)
      end
    end
    current_user_restaurants = Restaurant.where(user_id: current_user.id)
    @restaurant_all.concat(current_user_restaurants)
    tags = []
    @restaurant_all.each do |restaurant|
      following_user_tags = restaurant.tags
      tags.concat(following_user_tags)
    end
    @tags = tags.uniq
    # マップ、レストランの表示レストラン
    @tag = Tag.find(params[:tag_id])
    @restaurant_ransack = @p.result
    @restaurants_tag = @tag.restaurants
    @restaurants = @restaurant_ransack & @restaurant_all & @restaurants_tag
  end

  private

  def create_searching_object
    @p = Restaurant.ransack(params[:q])
  end

  def find_tag
    @tag = Tag.find(params[:id])
  end
end
