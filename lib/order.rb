require "sms"

class Order

  attr_reader :dishes

  def initialize(menu:, config: {}, sms: nil)
    @menu = menu
    @sms = sms || SMS.new(config)
    @dishes = {}
  end

  def add(dish, quantity)
    if menu.has_dish?(dish)
      dishes[dish] = quantity
    else
     fail StandardError, "#{dish.capitalize} is not on the menu!"
    end
  end

  def total
    item_totals.reduce(:+)
  end

  def place
    send_message
  end

  private

  attr_reader :menu, :sms

  def item_totals
    dishes.map do |dish, quantity|
      menu.price(dish) * quantity
    end
  end

  def send_message
    sms.deliver
  end
end
