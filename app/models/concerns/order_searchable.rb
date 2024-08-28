module OrderSearchable
  extend ActiveSupport::Concern

  included do
    scope :filter_by_customer_name, ->(customer_name) { 
      where("LOWER(customer_name) LIKE LOWER(?)", "%#{customer_name}%") if customer_name.present? 
    }
  
    scope :filter_by_address, ->(address) { 
      where("LOWER(address) LIKE LOWER(?)", "%#{address}%") if address.present? 
    }
  
    scope :filter_by_zip_code, ->(zip_code) { 
      where(zip_code: zip_code) if zip_code.present? 
    }
  
    scope :filter_by_shipping_method, ->(shipping_method) { 
      where("LOWER(shipping_method) LIKE LOWER(?)", "%#{shipping_method}%") if shipping_method.present? 
    }
  
    scope :filter_by_product_id, ->(product_id) { 
      where(product_id: product_id) if product_id.present? 
    }
  
    scope :filter_by_status, ->(status) { 
      where(status: status) if statuses.include?(status)
    }
  end
end