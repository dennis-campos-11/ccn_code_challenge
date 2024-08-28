module PreloadProductsData
  extend ActiveSupport::Concern

  private

  def set_products
    @products = Product.all.order(name: :asc)
  end
end