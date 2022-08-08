class Restaurant < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many   :restaurant_tags, dependent: :destroy
  has_many   :tags, through: :restaurant_tags, dependent: :destroy
  has_many :gos, dependent: :destroy
  has_many :wents, dependent: :destroy
  has_one :performance, dependent: :destroy

  def self.search(search)
    if search != ""
      Restaurant.where('restaurants.shop_name LIKE(?)', "%#{search}%")
    else
      Restaurant.all
    end
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  #validates :category_id, numericality: { other_than: 1 , message: "can't be blank"} 
end

