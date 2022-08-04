class TagsController < ApplicationController
  before_action :authenticate_user!, expect: [:show]
  before_action :create_searching_object, only: [:show, :search, :search_category]


  def show
    @tags = Tag.includes(:restaurants)
    @tag = Tag.find(params[:id])
    @restaurants = @tag.restaurants
  end

  def search
    @tag = Tag.find(params[:id])
    @tag_restaurants = @tag.restaurants
    @restaurants = @tag_restaurants.search(params[:keyword])
    @tags = Tag.includes(:restaurants)
  end

  def search_category
    @restaurants = @p.result
    @tags = Tag.includes(:restaurants)
  end

  private
  def create_searching_object
    @tag = Tag.find(params[:id])
    @tag_restaurants = @tag.restaurants
    @p = Restaurant.ransack(params[:q]) 
  end

end
