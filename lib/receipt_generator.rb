require_relative 'calculator/product'
require_relative 'calculator/tax_calculator'

module Calculator
  class ReceiptFormatter
    def self.format(receipt)
      totals = receipt.totals
      receipt_details = "\nReceipt:\n"

      totals[:receipt_data].each do |item|
        receipt_details += "#{item[:quantity]} #{item[:name]}: #{'%.2f' % item[:total]}\n"
      end

      receipt_details += "Sales Taxes: #{'%.2f' % totals[:total_tax]}\n"
      receipt_details += "Total: #{'%.2f' % totals[:total_cost]}\n"

      receipt_details
    end
  end

  class Receipt
    def initialize
      @products = []
    end

    def add_product(product, quantity: 1)
      @products << { product: product, quantity: quantity }
    end

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


# Example Usage 1
receipt = Calculator::Receipt.new

product1 = Calculator::Product.new(name: "book", base_price: 12.49, type: :book, imported: false)
receipt.add_product(product1, quantity: 2)

product2 = Calculator::Product.new(name: "music", base_price: 14.99, type: :other, imported: false)
receipt.add_product(product2, quantity: 1)

product2 = Calculator::Product.new(name: "chocolate", base_price: 0.85, type: :food, imported: false)
receipt.add_product(product2, quantity: 1)
puts Calculator::ReceiptFormatter.format(receipt)

# Example Usage 1
receipt = Calculator::Receipt.new

product1 = Calculator::Product.new(name: "chocolate", base_price: 10.00, type: :food, imported: true)
receipt.add_product(product1, quantity: 1)

product2 = Calculator::Product.new(name: "perfume", base_price: 47.50, type: :other, imported: true)
receipt.add_product(product2, quantity: 1)

puts Calculator::ReceiptFormatter.format(receipt)

# Example Usage 3
receipt = Calculator::Receipt.new

product1 = Calculator::Product.new(name: "perfume", base_price: 27.99, type: :other, imported: true)
receipt.add_product(product1, quantity: 1)

product2 = Calculator::Product.new(name: "perfume", base_price: 18.99, type: :other, imported: false)
receipt.add_product(product2, quantity: 1)

product3 = Calculator::Product.new(name: "headache pills", base_price: 9.75, type: :medical, imported: false)
receipt.add_product(product3, quantity: 1)

product4 = Calculator::Product.new(name: "chocolate", base_price: 11.25, type: :food, imported: true)
receipt.add_product(product4, quantity: 3)

puts Calculator::ReceiptFormatter.format(receipt)