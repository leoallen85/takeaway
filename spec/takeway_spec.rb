require "takeaway"

describe Takeaway do
  subject(:takeaway) do
    described_class.new(menu: menu, order_klass: order_klass, sms_klass: sms_klass, config: {})
  end
  let(:menu) { double(:menu, print: "Menu list") }
  let(:order_klass) { double("Order", new: order) }
  let(:order) { double(:order, total: 15.50, add: nil) }
  let(:sms_klass) { double("SMS", new: sms) }
  let(:sms) { double(:sms, deliver: nil) }

  it "shows the menu" do
    expect(takeaway.print_menu).to eq("Menu list")
  end

  it "can order some number of several available dishes" do
    dishes = {
      chicken: 2,
      fish: 1
    }

    expect(sms).to receive(:deliver)
    expect(takeaway.place_order(dishes)).to eq "Your order is for £15.50"
  end
end
