require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  include Helpers::Authentication
  
  it 'should allow to create a new order' do
    product = FactoryBot.create(:product)
    order_attributes = FactoryBot.attributes_for(:order)
    post :create, params: { order: order_attributes.merge(product_id: product.id) }

    expect(response).to have_http_status(302)
    expect(Order.count).to eq(1)
  end

  it 'should NOT create a new order when the product is out of stock' do
    product = FactoryBot.create(:product, stock: 0)
    order_attributes = FactoryBot.attributes_for(:order)
    post :create, params: { order: order_attributes.merge(product_id: product.id) }

    order = assigns(:order)
    expect(response).to have_http_status(422)
    expect(order.errors.values.flatten).to include("out of stock")
    expect(Order.count).to eq(0)
  end


end