class TagsController < ApplicationController
  before_action :authenticate_user!, expect: [:index]

  def show
    @tags = Tag.includes(:restaurants)
    @tag = Tag.find(params[:id])
    @restaurants = @tag.restaurants
  end
end
