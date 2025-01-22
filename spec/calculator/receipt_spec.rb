RSpec.describe Calculator::Receipt do
  let(:receipt) { described_class.new(Calculator::TaxCalculator.new) }

  it "adds products to the receipt" do
    product = Calculator::Product.new(name: "book", base_price: 12.49, type: :book, imported: false)

    receipt.add_product(product, quantity: 2)

    expect(receipt.products.size).to eq(1)
    expect(receipt.products.first[:product].name).to eq("book")
    expect(receipt.products.first[:quantity]).to eq(2)
  end

  it "calculates totals for the receipt" do
    skip
    product1 = Calculator::Product.new(name: "book", base_price: 12.49, type: :book, imported: false)
    product2 = Calculator::Product.new(name: "music CD", base_price: 14.99, type: :other, imported: false)
    receipt.add_product(product1, quantity: 1)
    receipt.add_product(product2, quantity: 1)

    totals = receipt.totals

    expect(totals[:total_cost]).to eq(28.98)
    expect(totals[:total_tax]).to eq(1.50)
  end

  it "calculates totals for the receipt - requested example 1" do
    receipt.add_product(
      Calculator::Product.new(name: "BOOK", base_price: 12.49, type: :book, imported: false), quantity: 2
    )

    receipt.add_product(
      Calculator::Product.new(name: "MUSIC", base_price: 14.99, type: :other, imported: false), quantity: 1
    )

    receipt.add_product(
      Calculator::Product.new(name: "FOOD", base_price: 0.85, type: :food, imported: false), quantity: 1
    )

    totals = receipt.totals

    expect(totals[:total_cost]).to eq(42.32)
    expect(totals[:total_tax]).to eq(1.50)
  end

  it "calculates totals for the receipt - requested example 2" do
    receipt.add_product(
      Calculator::Product.new(name: "chocolate", base_price: 10.00, type: :food, imported: true), quantity: 1
    )

    receipt.add_product(
      Calculator::Product.new(name: "perfume", base_price: 47.50, type: :other, imported: true), quantity: 1
    )

    totals = receipt.totals

    expect(totals[:total_cost]).to eq(65.15)
    expect(totals[:total_tax]).to eq(7.65)
  end

  it "calculates totals for the receipt - requested example 2" do
    receipt.add_product(
      Calculator::Product.new(name: "perfume", base_price: 27.99, type: :other, imported: true), quantity: 1
    )

    receipt.add_product(
      Calculator::Product.new(name: "perfume", base_price: 18.99, type: :other, imported: false), quantity: 1
    )

    receipt.add_product(
      Calculator::Product.new(name: "headache pills", base_price: 9.75, type: :medical, imported: false), quantity: 1
    )

    receipt.add_product(
      Calculator::Product.new(name: "chocolate", base_price: 11.25, type: :food, imported: true), quantity: 3
    )

    totals = receipt.totals

    expect(totals[:total_cost]).to eq(98.38)
    expect(totals[:total_tax]).to eq(7.90)
  end
end