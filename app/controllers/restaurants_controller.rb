class RestaurantsController < ApplicationController
  before_action :authenticate_user!
  #search_categoryに必要なransack(カテゴリー検索が出るindex, search_categoryのみ)
  before_action :create_searching_object, only: [:index, :search_category]
  #sidebarのインスタンス変数定義
  before_action :sidebar_def, only: [:index, :show, :search, :search_category]
  before_action :find_restaurant, only: [:edit, :update, :destroy, :show]
  #店登録のためのインスタンス生成(hiddenでいるから)
  before_action :restaurant_form, only: [:index, new, :update, :show, :search, :search_category]

  def index
    @restaurants = current_user.restaurants
  end

  def new
  end

  def create
    #インスタンス生成
    @restaurant_form = RestaurantForm.new(restaurant_form_params)
    #新規登録
    respond_to do |format|
      if @restaurant_form.valid?
        @restaurant_form.save
        @restaurants = current_user.restaurants
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
        format.js
      else
        format.html { render :new } 
      end
    end
  end

  def edit
    #編集画面にタグ名入れようとして（初期値として） 書いたけどダメだった、、
    tag_array = []
    @restaurant.tags.each do |tag|
      tag_array.push(tag.tag_name)
    end
    @tag_join = tag_array.join(',')
    #編集のインスタンス生成
    @restaurant_form_edit = RestaurantForm.new(shop_name: @restaurant.shop_name, category_id: @restaurant.category_id, phone_number: @restaurant.phone_number, url: @restaurant.url, tag_name: @tag_join)
  end

  def update
    #編集のインスタンス生成
    @restaurant_form_edit = RestaurantForm.new(restaurant_form_update_params)
    #imageが空でも元々の登録画像が保持されるように（もともと画像登録されてない場合はそのまま）
    if @restaurant_form_edit.image == nil && @restaurant.image.attached?
      @restaurant_form_edit.image = @restaurant.image.blob
    end
    #更新
    respond_to do |format|
      if @restaurant_form_edit.valid?
        @restaurant_form_edit.update
        @restaurant = Restaurant.find(params[:id])
        @performance = @restaurant.performance
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
        format.js
      else
        format.html { render :edit } 
      end
    end
    #コメントブロック
    @comments = @restaurant.comments
    @comment = Comment.new
  end

  def destroy
    @restaurant.destroy
    redirect_to root_path
  end

  def show
    #main
    @performance = @restaurant.performance
    @comments = @restaurant.comments
    @comment = Comment.new
    #店登録、店編集
    @restaurant_form_edit = RestaurantForm.new(shop_name: @restaurant.shop_name, category_id: @restaurant.category_id, phone_number: @restaurant.phone_number, url: @restaurant.url, address: @restaurant.performance.address)
  end


  #searchメソッドはモデルでクラスメソッドを定義している
  def search
    #マップ、レストランの表示レストラン
    @restaurant_search = Restaurant.search(params[:keyword])
    @restaurants = @restaurant_search.where(user_id: current_user.id)
  end

  def search_category
    #マップ、レストランの表示レストラン
    @restaurant_ransack = @p.result
    @restaurants = @restaurant_ransack.where(user_id: current_user.id)
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

  def sidebar_def
    #サイドバー（全て）、マップ、レストランの表示レストラン
    #ログインしているユーザーが投稿したレストランのみ取得
    @restaurant_all = current_user.restaurants
    #サイドバーのタグ
    #sidebarにはログインしているユーザーが投稿したタグのみ表示
    #@tag_arrayでログインユーザーが投稿したものを配列に追加、@tagsで重複要素を排除
    #レストランがない駅は表示されない
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
  end

  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_form
    @restaurant_form = RestaurantForm.new
  end
 
end

