class TagsController < ApplicationController
  before_action :authenticate_user!, expect: [:index]

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
end
