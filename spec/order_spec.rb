require "order"

describe Order do
  subject(:order) { described_class.new(menu) }

  let(:menu) { double(:menu) }

  let(:dishes) do
    {
      chicken: 2,
      fish: 1
    }
  end

  before do
    allow(menu).to receive(:has_dish?).with(:chicken).and_return(true)
    allow(menu).to receive(:has_dish?).with(:fish).and_return(true)
    allow(menu).to receive(:has_dish?).with(:beef).and_return(false)

    allow(menu).to receive(:price).with(:chicken).and_return(3.00)
    allow(menu).to receive(:price).with(:fish).and_return(2.50)
  end

  it "selects several dishes from the menu" do
    create_order
    expect(order.dishes).to eq(dishes)
  end

  it "doesn't allow to add items that are not on the menu" do
    expect{ order.add(:beef, 2) }.to raise_error(StandardError, "Beef is not on the menu!")
  end

  it "calculates the total for the order" do
    create_order
    total = 8.50
    expect(order.total).to eq(total)
  end

  def create_order
    order.add(:chicken, 2)
    order.add(:fish, 1)
  end
end
