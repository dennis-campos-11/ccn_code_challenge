FactoryBot.define do
  factory :order do
    customer_name { "MyString" }
    address { "San Jose" }
    zip_code { 1 }
    shipping_method { "MyString" }
    association :product, factory: :product
  end
end
