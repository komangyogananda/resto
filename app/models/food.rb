class Food < ApplicationRecord
  validates_presence_of :name
  validates :description, presence: true, length: { maximum: 100 }
  validates :price, presence: true, numericality: { only_float: true }
end
