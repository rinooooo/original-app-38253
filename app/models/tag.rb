class Tag < ApplicationRecord
  has_many   :restaurant_tags
  has_many   :restaurants, through: :restaurant_tags

  def self.search(search)
    if search != ""
      Restaurant.where('restaurants.shop_name LIKE(?)', "%#{search}%")
    else
      @tag = Tag.find(params[:id])
      @tag.restaurants
    end
  end
  
end
