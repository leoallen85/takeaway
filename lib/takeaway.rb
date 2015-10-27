require_relative "order"
require_relative "sms"
require_relative "menu"

class Takeaway
  def initialize(menu: nil, order: nil, sms: nil, config: {})
    @menu  = menu
    @order = order || Order.new(menu)
    @sms   = sms || SMS.new(config)
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
