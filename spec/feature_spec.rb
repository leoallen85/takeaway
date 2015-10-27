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
    takeaway = Takeaway.new(menu: menu, config: config)

    expect(takeaway).to receive(:send_message)
    expect(takeaway.place_order(chicken: 3, falafel: 4)).to eq "Your order is for £19.50"
  end

end
