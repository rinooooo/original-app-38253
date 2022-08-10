class RestaurantsController < ApplicationController
  before_action :authenticate_user!
  #search_categoryに必要なransack(カテゴリー検索が出るindex, search_categoryのみ)
  before_action :create_searching_object, only: [:index, :search_category]

  def index
    #サイドバー（全て）、マップ、レストランの表示レストラン
    #ログインしているユーザーが投稿したレストランのみ取得
    @restaurants = current_user.restaurants
    #サイドバーのタグ
    #sidebarにはログインしているユーザーが投稿したタグのみ表示
    #@tag_arrayでログインユーザーが投稿したものを配列に追加、@tagsで重複要素を排除
    @tag_array = []
    @restaurants.each do |restaurant|
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

  def new
    #店登録のためのインスタンス生成
    @restaurant_form = RestaurantForm.new
  end

  def create
    @tags = Tag.includes(:restaurants)

    #店登録のためのインスタンス生成
    @restaurant_form = RestaurantForm.new(restaurant_form_params)
    respond_to do |format|
      if @restaurant_form.valid?
        @restaurant_form.save
        @restaurants = current_user.restaurants
        format.js
      else
        format.html { render :new } 
      end
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    tag_array = []
    @restaurant.tags.each do |tag|
      tag_array.push(tag.tag_name)
    end
    @tag_join = tag_array.join(',')
    @restaurant_form_edit = RestaurantForm.new(shop_name: @restaurant.shop_name, category_id: @restaurant.category_id, phone_number: @restaurant.phone_number, url: @restaurant.url, tag_name: @tag_join)
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant_form_edit = RestaurantForm.new(restaurant_form_update_params)
    if @restaurant_form_edit.image == nil && @restaurant.image.attached?
      @restaurant_form_edit.image = @restaurant.image.blob
    end
    respond_to do |format|
      if @restaurant_form_edit.valid?
        @restaurant_form_edit.update
        @restaurant = Restaurant.find(params[:id])
        @performance = @restaurant.performance
        format.js
      else
        format.html { render :edit } 
      end
    end
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
    #main
    @comments = @restaurant.comments
    @comment = Comment.new
    #店登録、店編集
    @restaurant_form = RestaurantForm.new
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to root_path
  end

  def show
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
    #main
    @restaurant = Restaurant.find(params[:id])
    @performance = @restaurant.performance
    @comments = @restaurant.comments
    @comment = Comment.new
    #店登録、店編集
    @restaurant_form = RestaurantForm.new
    @restaurant_form_edit = RestaurantForm.new(shop_name: @restaurant.shop_name, category_id: @restaurant.category_id, phone_number: @restaurant.phone_number, url: @restaurant.url, address: @restaurant.performance.address)
  end


  #searchメソッドはモデルでクラスメソッドを定義している
  def search
    #マップ、レストランの表示レストラン
    @restaurant_search = Restaurant.search(params[:keyword])
    @restaurants = @restaurant_search.where(user_id: current_user.id)
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

  def search_category
    #マップ、レストランの表示レストラン
    @restaurant_ransack = @p.result
    @restaurants = @restaurant_ransack.where(user_id: current_user.id)
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
  def restaurant_form_params
    params.require(:restaurant_form).permit(:shop_name, :address, :category_id, :phone_number, :url, :image, :tag_name, :longitude, :latitude).merge(user_id: current_user.id)
  end

  def restaurant_form_update_params
    params.require(:restaurant_form).permit(:shop_name, :address, :category_id, :phone_number, :url, :image, :tag_name, :longitude, :latitude).merge(user_id: current_user.id, restaurant_id: @restaurant.id)
  end

  def create_searching_object
    @p = Restaurant.ransack(params[:q]) 
  end

 
end

