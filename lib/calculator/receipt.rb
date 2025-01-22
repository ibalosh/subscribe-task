module Calculator
  class Receipt
    def initialize
      @products = []
    end

    # @param product [Product] The product to add to the receipt
    def add_product(product, quantity: 1)
      @products << { product: product, quantity: quantity }
    end

    # @return [Hash] The receipt totals
    def totals
      total_cost = 0
      total_tax = 0
      receipt_data = []

      @products.each do |item|
        product = item[:product]
        quantity = item[:quantity]
        tax_calculator = Calculator::TaxCalculator.new

        item_tax = tax_calculator.calculate(product) * quantity
        item_total = (product.base_price + tax_calculator.calculate(product)) * quantity

        total_cost += item_total
        total_tax += item_tax

        receipt_data << { quantity: quantity, name: product.name, total: item_total }
      end

      { receipt_data: receipt_data, total_tax: total_tax, total_cost: total_cost }
    end
  end
end