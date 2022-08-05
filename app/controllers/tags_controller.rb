class TagsController < ApplicationController
  before_action :authenticate_user!, expect: [:show]


  def show
    @tags = Tag.includes(:restaurants)
    @tag = Tag.find(params[:id])
    @restaurants = @tag.restaurants
  end

end
