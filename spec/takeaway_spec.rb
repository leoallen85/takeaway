require "menu"
require "order"

describe "Takeaway" do

  it "creates an order" do
    dishes = {
      chicken: 2.50,
      falafel: 3.00
    }

    menu = Menu.new(dishes)
    order = Order.new(menu)
    order.add(:chicken, 3)
    order.add(:falafel, 4)
    expect(order.total).to eq(19.50)
  end

end
