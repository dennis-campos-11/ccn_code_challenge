class Orders

  def self.create(params)
    order = Order.new(params)
    Order.transaction do
      order.save!
      raise ActiveRecord::Rollback unless order.refresh_inventory!
    end
    order
  rescue ActiveRecord::RecordInvalid => invalid
    return order
  end

  def self.search(params)
    Order.includes(:product)
         .filter_by_customer_name(params[:customer_name])
         .filter_by_address(params[:address])
         .filter_by_zip_code(params[:zip_code])
         .filter_by_shipping_method(params[:shipping_method])
         .filter_by_product_id(params[:product_id])
         .filter_by_status(params[:status])
  end
end