require "order"
require "sms"

class Takeaway
  def initialize(menu:, order_klass: Order, sms_klass: SMS, config: {})
    @menu = menu
    @order = order_klass.new(menu)
    @sms = sms_klass.new(config)
  end

  def print_menu
    menu.print
  end

  def place_order(dishes)
    add_dishes(dishes)
    send_message
    "Your order is for £%.2f" % order.total
  end

  private

  def add_dishes(dishes)
    dishes.each do |dish, quantity|
      @order.add(dish, quantity)
    end
  end

  def send_message
    sms.deliver
  end

  attr_reader :menu, :order, :sms
end
