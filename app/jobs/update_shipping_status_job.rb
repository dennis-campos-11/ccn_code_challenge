class UpdateShippingStatusJob < ActiveJob::Base
  queue_as :critical
  unique :until_executed

  after_perform do |job|
    order = Order.find(job.arguments.first)
    ShipmentMailer.with(order: order).update_shipment_status_email.deliver_later
  end

  def perform(order_id)
    order = Order.find(order_id)
    raise Fedex::ShipmentNotFound if order.shipment_id.nil?
    shipment = FedexV2::Shipment.find(order.shipment_id)
  rescue Fedex::ShipmentNotFound => e
    shipment = FedexV2::Shipment.create
    p "error: #{e}"
  ensure 
    order.update({
      shipment_id: shipment.id,
      status: shipment.status
    }) if order.present? && shipment.present?
  end
end
