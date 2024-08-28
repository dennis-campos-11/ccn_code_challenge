require 'rails_helper'

RSpec.describe Orders do
  before(:each) do
    @product_1 =  FactoryBot.create(:product)
    @product_2 = FactoryBot.create(:product)
    @order1 = FactoryBot.create(:order, customer_name: "Juan", address: "Buenos Aires", zip_code: 999, product: @product_1)
    @order2 = FactoryBot.create(:order, customer_name: "Pedro", address: "San Jose", product: @product_1)
    @order3 = FactoryBot.create(:order, customer_name: "Maria", address: "New York", product: @product_2)
    @order4 = FactoryBot.create(:order, customer_name: "Oscar", address: "New York", product: @product_1)
  end

  it 'should filter by product' do
    params = { product_id: @product_1.id }
    orders = Orders.search(params)
    expect(orders.count).to eq(3)
    expect(orders).to eq([@order1, @order2, @order4])
  end

  it 'should filter by customer_name' do
    params = { customer_name: "Pedro" }
    orders = Orders.search(params)
    expect(orders.count).to eq(1)
    expect(orders).to eq([@order2])
  end

  it 'should filter by address' do
    params = { address: "New York" }
    orders = Orders.search(params)
    expect(orders.count).to eq(2)
    expect(orders).to eq([@order3, @order4])
  end

  it 'should filter by zip code' do
    params = { zip_code: "999" }
    orders = Orders.search(params)
    expect(orders.count).to eq(1)
    expect(orders).to eq([@order1])
  end
end