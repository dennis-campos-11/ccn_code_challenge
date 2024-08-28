class UpdatePendingOrdersShippingStatusJob < ActiveJob::Base
  queue_as :critical
  unique :until_executed

  def perform
    orders = Order.not_delivered
    orders.in_batches.each do |orders_in_batches|
      orders_in_batches.each do |order|
        UpdateShippingStatusJob.perform_later(order.id)
      end
    end
  end
end
