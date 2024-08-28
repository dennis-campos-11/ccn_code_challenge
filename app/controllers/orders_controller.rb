class OrdersController < ApplicationController
  include PreloadProductsData
  before_action :set_order, :set_products, only: [:show, :destroy]
  before_action :set_products, only: [:new, :edit, :create]

  def show
  end

  def new
    @order = Order.new
  end

  def create
    @order = Orders.create(order_params)
    respond_to do |format|
      if !@order.errors.present?
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:product_id, :customer_name, :address, :zip_code, :shipping_method)
  end
end
