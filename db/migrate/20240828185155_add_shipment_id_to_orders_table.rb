class AddShipmentIdToOrdersTable < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :shipment_id, :integer
  end
end
