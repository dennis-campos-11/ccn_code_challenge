module FedexV2
  class Shipment < Fedex::Shipment
    def self.find(fedex_id)
      @shipments ||= []
      shipment = @shipments[fedex_id]

      raise Fedex::ShipmentNotFound, "Shipment not found: #{fedex_id}" if shipment.blank?

      shipment.status = STATUS.shuffle.first

      shipment
    end
  end
end
