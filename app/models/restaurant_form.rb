class RestaurantForm
  include ActiveModel::Model

  attr_accessor :shop_name, :address, :category_id, :phone_number, :url, :image, :user_id,
                :id, :created_at, :datetime, :updated_at, :datetime,
                :tag_name, :restaurant_id,
                :latitude, :longitude

  with_options presence: true do
    validates :shop_name
    validates :tag_name
    validates :user_id
    validates :category_id, numericality: { other_than: 1, message: 'カテゴリーを入力してください' }
    validates :address
  end

  def save
    restaurant = Restaurant.create(shop_name: shop_name, category_id: category_id, phone_number: phone_number, url: url,
                                   image: image, user_id: user_id)
    tag = Tag.where(tag_name: tag_name).first_or_initialize
    tag.save
    Performance.create(address: address, latitude: latitude, longitude: longitude, restaurant_id: restaurant.id)
    RestaurantTag.create(restaurant_id: restaurant.id, tag_id: tag.id)
  end

  def update
    restaurant = Restaurant.where(id: restaurant_id)
    restaurant.update(shop_name: shop_name, category_id: category_id, phone_number: phone_number, url: url, image: image,
                      user_id: user_id)
    tag = Tag.where(tag_name: tag_name).first_or_initialize
    tag.update(tag_name: tag_name)
    performance = Performance.where(restaurant_id: restaurant_id)
    performance.update(address: address, latitude: latitude, longitude: longitude, restaurant_id: restaurant_id)
    @restaurant_tag = RestaurantTag.where(restaurant_id: restaurant_id)
    @restaurant_tag.update(restaurant_id: restaurant_id, tag_id: tag.id)
  end
end
