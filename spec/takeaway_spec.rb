require "menu"
require "order"

describe "Takeaway" do

  it "creates an order and sends a message" do
    dishes = {
      chicken: 2.50,
      falafel: 3.00
    }

    config = {
      account_sid: "123",
      auth_token: "234",
      from: "+123",
      to: "+345",
      body: "Thank you! Your order will be delivered before %s"
    }

    menu = Menu.new(dishes)
    order = Order.new(config: config, menu: menu)
    order.add(:chicken, 3)
    order.add(:falafel, 4)
    expect(order.total).to eq(19.50)

    expect(order).to receive(:send_message)
    order.place
  end

end
