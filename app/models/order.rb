class Order < ApplicationRecord
  include OrderSearchable

  enum status: ['processing'].concat(Fedex::Shipment::STATUS).freeze
  validates :customer_name, :address, :zip_code, :shipping_method, presence: true
  belongs_to :product

  before_create :set_default_status

  scope :not_delivered, -> { where.not(status: 'delivered') }

  def refresh_inventory!
    stock = product.stock
    unless product.update(stock: stock - 1)
      self.errors.add(:product, "out of stock")
      return false
    end
    true
  end

  private

  def set_default_status
    self.status = 'processing'
  end
end
