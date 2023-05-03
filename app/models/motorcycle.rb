class Motorcycle < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :users, through: :reservations, dependent: :destroy

  validates :name, :price, :description, :image, :category, presence: true
  validates :name, :category, length: { maximum: 100 }
  validates :image, :description, length: { maximum: 400 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
