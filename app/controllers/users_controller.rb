class UsersController < ApplicationController
  def index
    @restaurants =  Restaurant.includes(:user)
    #サイドバー（全て）、マップ、レストランの表示レストラン
    #全レストランを取得
    @restaurant_all = Restaurant.includes(:user)
    #サイドバーのタグ
    #sidebarには全タグを表示、レストランがないタグは表示されない
    @tag_array = []
    @restaurant_all.each do |restaurant|
      tags = restaurant.tags
      tags.each do |tag|
        @tag_array.push(tag)
      end
    end
    @tags = @tag_array.uniq
    #new
    @restaurant_form = RestaurantForm.new
    #search_category
    @p = Restaurant.ransack(params[:q]) 
  end


end
