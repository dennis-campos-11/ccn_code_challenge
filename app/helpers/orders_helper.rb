module OrdersHelper

  def order_statuses_options
    Order.statuses.map { |status| [status.first.humanize, status.first] }
  end
end
