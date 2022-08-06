class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :group_name, presence: true

  has_many :restaurants
  has_many :gos, dependent: :destroy
  has_many :wents, dependent: :destroy
end
