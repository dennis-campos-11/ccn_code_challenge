class ShipmentMailer < ApplicationMailer
  def update_shipment_status_email
    @order = params[:order]
    mail(to: ENV['EMAIL'], subject: "Shipment was updated!")
  end
end
