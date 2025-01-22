RSpec.describe Calculator::Product do
  it "initializes with correct attributes" do
    product = described_class.new(name: "PRODUCT NAME", base_price: 1.0, type: :book, imported: false)

    expect(product.name).to eq("PRODUCT NAME")
    expect(product.base_price).to eq(1.0)
    expect(product.type).to eq(:book)
    expect(product.imported).to eq(false)
  end

  it "initializes with incorrect product type" do
    expect{ described_class.new(name: "book", base_price: 12.49, type: :books, imported: false) }.to raise_error
  end
end