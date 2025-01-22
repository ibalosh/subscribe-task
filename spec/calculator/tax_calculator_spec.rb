RSpec.describe Calculator::TaxCalculator do
  let(:tax_calculator) { described_class.new }

  it "calculates tax for non-exempt and non-imported products" do
    product = Calculator::Product.new(name: "PRODUCT NAME", base_price: 10, type: :other, imported: false)

    expect(tax_calculator.calculate(product)).to eq(1)
  end

  it "calculates tax for exempt and non-imported products" do
    product = Calculator::Product.new(name: "book", base_price: 10, type: :book, imported: false)

    expect(tax_calculator.calculate(product)).to eq(0.0)
  end

  it "calculates additional tax for imported products" do
    product = Calculator::Product.new(name: "PRODUCT NAME", base_price: 10, type: :food, imported: true)

    expect(tax_calculator.calculate(product)).to eq(0.50)
  end

  it "calculates additional tax for imported products and non-exempt products" do
    product = Calculator::Product.new(name: "PRODUCT NAME", base_price: 10, type: :other, imported: true)

    expect(tax_calculator.calculate(product)).to eq(1.50)
  end
end