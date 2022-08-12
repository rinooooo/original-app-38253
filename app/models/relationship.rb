class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  def self.search(search)
    if search != ""
      Restaurant.where('restaurants.shop_name LIKE(?)', "%#{search}%")
    else
      Restaurant.all
    end
  end
end
