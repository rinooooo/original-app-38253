class RestaurantForm
  include ActiveModel::Model

  attr_accessor :shop_name, :address, :category_id, :phone_number, :url, :image, :user_id,
                :id, :created_at, :datetime, :updated_at, :datetime,
                :tag_name

  with_options presence: true do
    validates :shop_name
    validates :category_id, numericality: { other_than: 1 , message: "can't be blank"} 
  end

  def save
    restaurant = Restaurant.create(shop_name: shop_name, address: address, category_id: category_id, phone_number: phone_number, url: url, image: image, user_id: user_id)
    tag = Tag.where(tag_name: tag_name).first_or_initialize
    tag.save
    RestaurantTag.create(restaurant_id: restaurant.id, tag_id: tag.id)
  end
end