require "order"

describe Order do
  subject(:order) { described_class.new(menu: menu, sms: sms) }

  let(:menu) { double(:menu) }
  let(:sms) { spy(:sms) }
  let(:config) { :config }

  let(:dishes) do
    {
      chicken: 2,
      fish: 1
    }
  end

  before do
    allow(menu).to receive(:price).with(:chicken).and_return(3.00)
    allow(menu).to receive(:price).with(:fish).and_return(2.50)
  end

  it "selects several dishes from the menu" do
    create_order
    expect(order.dishes).to eq(dishes)
  end

  it "calculates the total for the order" do
    create_order
    total = 8.50
    expect(order.total).to eq(total)
  end

  it "sends a message when the order is placed" do
    create_order
    order.place
    expect(sms).to have_received(:deliver)
  end

  def create_order
    order.add(:chicken, 2)
    order.add(:fish, 1)
  end
end
