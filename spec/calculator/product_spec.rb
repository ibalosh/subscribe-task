RSpec.describe Calculator::Product do
  it "initializes with correct attributes" do
    product = described_class.new(name: "PRODUCT NAME", base_price: 1.0, type: :book, imported: false)

    aggregate_failures "product attributes" do
      expect(product.name).to eq("PRODUCT NAME")
      expect(product.base_price).to eq(1.0)
      expect(product.type).to eq(:book)
      expect(product.imported).to eq(false)
    end
  end
end