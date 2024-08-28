class RenameAdressToAddress < ActiveRecord::Migration[5.2]
  def change
    rename_column :orders, :adress, :address
  end
end
