require "menu"

describe Menu do

  subject(:menu) { described_class.new([dish]) }

  let(:dish) { double("Dish", price: 1) }

  it "shows a list of dishes with prices" do
    expect(menu.dishes).to include(dish)
  end
end
