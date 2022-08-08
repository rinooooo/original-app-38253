class Performance < ApplicationRecord
  belongs_to :restaurant

  geocoded_by :address
  after_validation :geocode
end
