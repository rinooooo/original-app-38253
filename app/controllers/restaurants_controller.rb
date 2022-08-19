class RestaurantsController < ApplicationController
  before_action :authenticate_user!
  # search_categoryに必要なransack(カテゴリー検索が出るindex, search_categoryのみ)
  before_action :create_searching_object, only: [:index, :search_category]
  # sidebarのインスタンス変数定義(友達登録用インスタンス変数含む)
  before_action :sidebar_def, only: [:index, :show, :search, :search_category]
  # URI内のIDからレコードを取得する
  before_action :find_restaurant, only: [:edit, :update, :destroy, :show]
  # 店登録のためのインスタンス生成(hiddenでいるから)
  before_action :restaurant_form, only: [:index, new, :update, :show, :search, :search_category]
  # コメント
  before_action :comment_form, only: [:show, :update]

  def index
    @restaurants = current_user.restaurants
  end

  def new
  end

  def create
    # インスタンス生成
    @restaurant_form = RestaurantForm.new(restaurant_form_params)
    # 新規登録
    if @restaurant_form.valid?
      @restaurant_form.save
      @restaurants = current_user.restaurants
      @tag_array = []
      @restaurants.each do |restaurant|
        next unless restaurant.user_id == current_user.id

        tags = restaurant.tags
        tags.each do |tag|
          @tag_array.push(tag)
        end
      end
      @tags = @tag_array.uniq
      @following_users = current_user.followings
      @follower_users = current_user.followers
    else
      render 'restaurants/error'
    end
  end

  def edit
    # 編集のインスタンス生成
    @restaurant_form_edit = RestaurantForm.new(shop_name: @restaurant.shop_name, category_id: @restaurant.category_id,
                                               phone_number: @restaurant.phone_number, url: @restaurant.url, tag_name: @tag_join)
  end

  def update
    # 編集のインスタンス生成
    @restaurant_form_edit = RestaurantForm.new(restaurant_form_update_params)
    # imageが空でも元々の登録画像が保持されるように（もともと画像登録されてない場合はそのまま）
    @restaurant_form_edit.image = @restaurant.image.blob if @restaurant_form_edit.image.nil? && @restaurant.image.attached?
    # 更新
    if @restaurant_form_edit.valid?
      @restaurant_form_edit.update
      @restaurant = Restaurant.find(params[:id])
      @performance = @restaurant.performance
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
      @following_users = current_user.followings
      @follower_users = current_user.followers
    else
      render 'restaurants/error_edit'
    end
  end

  def destroy
    @restaurant.destroy if current_user.id = @restaurant.user_id
    redirect_to root_path
  end

  def show
    # main
    @performance = @restaurant.performance
    # 店登録、店編集
    @restaurant_form_edit = RestaurantForm.new(shop_name: @restaurant.shop_name, category_id: @restaurant.category_id,
                                               phone_number: @restaurant.phone_number, url: @restaurant.url, address: @restaurant.performance.address)
  end

  # searchメソッドはモデルでクラスメソッドを定義している
  # マイページワード検索
  def search
    # マップ、レストランの表示レストラン
    @restaurant_search = Restaurant.search(params[:keyword])
    @restaurants = @restaurant_search.where(user_id: current_user.id)
  end

  # マイページカテゴリー検索
  def search_category
    # マップ、レストランの表示レストラン
    @restaurant_ransack = @p.result
    @restaurants = @restaurant_ransack.where(user_id: current_user.id)
  end

  private

  def restaurant_form_params
    params.require(:restaurant_form).permit(:shop_name, :address, :category_id, :phone_number, :url, :image, :tag_name,
                                            :longitude, :latitude).merge(user_id: current_user.id)
  end

  def restaurant_form_update_params
    params.require(:restaurant_form).permit(:shop_name, :address, :category_id, :phone_number, :url, :image, :tag_name, :longitude, :latitude).merge(
      user_id: current_user.id, restaurant_id: @restaurant.id
    )
  end

  def create_searching_object
    @p = Restaurant.ransack(params[:q])
  end

  def sidebar_def
    # サイドバー（全て）、マップ、レストランの表示レストラン
    # ログインしているユーザーが投稿したレストランのみ取得
    @restaurant_all = current_user.restaurants
    # サイドバーのタグ
    # sidebarにはログインしているユーザーが投稿したタグのみ表示
    # @tag_arrayでログインユーザーが投稿したものを配列に追加、@tagsで重複要素を排除
    # レストランがない駅は表示されない
    @tag_array = []
    @restaurant_all.each do |restaurant|
      next unless restaurant.user_id == current_user.id

      tags = restaurant.tags
      tags.each do |tag|
        @tag_array.push(tag)
      end
    end
    @tags = @tag_array.uniq
    # フォローフォロワー
    @following_users = current_user.followings
    @follower_users = current_user.followers
    # 新規友達フォローページのインスタンス変数
    @users_all = User.all
    @users = @users_all.where.not(id: current_user.id)
  end

  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_form
    @restaurant_form = RestaurantForm.new
  end

  def comment_form
    @comments = @restaurant.comments
    @comment = Comment.new
  end
end
