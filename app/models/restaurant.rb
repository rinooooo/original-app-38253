class Restaurant < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many   :restaurant_tags
  has_many   :tags, through: :restaurant_tags

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  #validates :category_id, numericality: { other_than: 1 , message: "can't be blank"} 
end
