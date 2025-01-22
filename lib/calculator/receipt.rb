require_relative 'tax_calculator'

module Calculator
  class Receipt
    attr_reader :products
    private attr_reader :tax_calculator

    def initialize(tax_calculator)
      @products = []
      @tax_calculator = tax_calculator
    end

    # @param product [Product] The product to add to the receipt
    # @param [Integer] quantity
    def add_product(product, quantity: 1)
      @products << { product: product, quantity: quantity }
    end

    # @return [Hash] The receipt totals
    def totals
      total_cost = 0
      total_tax = 0

      receipt_data = @products.map do |item|
        product = item[:product]
        quantity = item[:quantity]

        item_tax = (tax_calculator.calculate(product) * quantity)
        item_total = ((product.base_price + tax_calculator.calculate(product)) * quantity)

        total_cost += item_total
        total_tax += item_tax

        { quantity: quantity, name: product.name, total: item_total }
      end

      # In Ruby as in other languages, when doing floating-point arithmetic, you could end up with things like
      # 1.4 + 1.2 != 2.6, but 1.4 + 1.2 = 2.59999
      # Due that, we will round the numbers after second decimal.
      total_tax = total_tax.round(2)
      total_cost = total_cost.round(2)

      { receipt_data: receipt_data, total_tax: total_tax, total_cost: total_cost }
    end
  end
end