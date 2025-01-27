class Product < ActiveRecord::Base
  validates :name, :price, :stock, presence: true
  validates :stock, numericality: { greater_than_or_equal_to: 0 }
end
