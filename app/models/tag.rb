class Tag < ApplicationRecord
  has_many   :restaurant_tags, dependent: :destroy
  has_many   :restaurants, through: :restaurant_tags, dependent: :destroy
end
