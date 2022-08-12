class RelationshipsController < ApplicationController
  #search_categoryに必要なransack(カテゴリー検索が出るindex, search_categoryのみ)
  before_action :create_searching_object, only: [:show, :search_category]

  def new
    @users_all = User.all
    @users = @users_all.where.not(id: current_user.id)
  end

  def show
    @following_users = current_user.followings
    @follower_users = current_user.followers
    #フォローしている人（＋自分）が投稿した全てのレストラン
    @restaurants = []
    if @following_users.present?
      @following_users.each do |user|
        following_user_restaurants = Restaurant.where(user_id: user.id)
        @restaurants.concat(following_user_restaurants)
      end
    end
    current_user_restaurants = Restaurant.where(user_id: current_user.id)
    @restaurants.concat(current_user_restaurants)
    #フォローしている人が投稿したレストランのタグ一覧
    tags = []
    @restaurants.each do |restaurant|
      following_user_tags = restaurant.tags
      tags.concat(following_user_tags)
    end
    @tags = tags.uniq
    #フレンド登録
    @users_all = User.all
    @users = @users_all.where.not(id: current_user.id)
  end

  #searchメソッドはモデルでクラスメソッドを定義している
  def search
    #（サイドバー）
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
    #検索結果
    @searh_restaurants = Restaurant.search(params[:keyword])
    @restaurants = @searh_restaurants & @restaurant_all
    #フレンド登録
    @users_all = User.all
    @users = @users_all.where.not(id: current_user.id)
  end

  def search_category
    #（サイドバー）
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
    #マップ、レストランの表示レストラン
    @restaurant_ransack = @p.result
    @restaurants = @restaurant_ransack & @restaurant_all
    #フレンド登録
    @users_all = User.all
    @users = @users_all.where.not(id: current_user.id)
  end

  # フォローするとき
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  # フォロー外すとき
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer  
  end
  # フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end
  # フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end

  def create_searching_object
    @p = Restaurant.ransack(params[:q]) 
  end

end
