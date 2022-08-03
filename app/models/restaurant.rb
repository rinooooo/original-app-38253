class Restaurant < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  #validates :category_id, numericality: { other_than: 1 , message: "can't be blank"} 
end
