RSpec.describe Calculator::Receipt::Formatter do
  it "formats a receipt into a string" do
    receipt = Calculator::Receipt.new(Calculator::TaxCalculator.new)
    product1 = Calculator::Product.new(name: "BOOK NAME", base_price: 12.49, type: :book, imported: false)
    product2 = Calculator::Product.new(name: "MUSIC CD", base_price: 14.99, type: :other, imported: false)
    receipt.add_product(product1, quantity: 1)
    receipt.add_product(product2, quantity: 1)

    result = described_class.format(receipt)

    expect(result).to include("1 BOOK NAME: 12.49")
    expect(result).to include("1 MUSIC CD: 16.49")
    expect(result).to include("Sales Taxes: 1.50")
    expect(result).to include("Total: 28.98")
  end
end