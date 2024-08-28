class Admin::OrdersController < ApplicationController
  include PreloadProductsData
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :destroy]
  before_action :set_products, only: [:index]

  def index
    @orders = Orders.search(params)
  end

  def show
    render "orders/show"
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to admin_orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def set_products
    @products = Product.all.order(name: :asc)
  end
end
