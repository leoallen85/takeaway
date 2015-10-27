require "takeaway"

describe Takeaway do
  subject(:takeaway) do
    described_class.new(menu: menu, order: order, sms: sms, config: {})
  end
  let(:menu) { double(:menu, print: "Menu list") }
  let(:order) { double(:order, total: 15.50, add: nil) }
  let(:sms) { double(:sms, deliver: nil) }
  let(:menu_list) { {chicken: 2.50, fish: 1.30, falafel: 3.00} }
  let(:dishes) { {chicken: 2, fish: 1} }

  it "shows the menu" do
    expect(takeaway.print_menu).to eq("Menu list")
  end

  it "can order some number of several available dishes" do
    expect(sms).to receive(:deliver)
    expect(takeaway.place_order(dishes)).to eq("Your order is for £15.50")
  end
end
