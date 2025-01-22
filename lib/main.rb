require_relative 'calculator/receipt'
require_relative 'calculator/receipt_formatter'
require_relative 'calculator/product'
require_relative 'calculator/product_type_validator'

# Example Usage
receipt = Calculator::Receipt.new

products = [
  [Calculator::Product.new(name: "book", base_price: 12.49, type: :book, imported: false),2],
  [Calculator::Product.new(name: "music", base_price: 14.99, type: :other, imported: false),1],
  [Calculator::Product.new(name: "chocolate", base_price: 0.85, type: :food, imported: false),1]
]

products.each { |product, quantity| receipt.add_product(product, quantity: quantity) }
puts Calculator::ReceiptFormatter.format(receipt)

# Example Usage
receipt = Calculator::Receipt.new

products = [
  [Calculator::Product.new(name: "chocolate", base_price: 10.00, type: :food, imported: true),1],
  [Calculator::Product.new(name: "perfume", base_price: 47.50, type: :other, imported: true),1]]

products.each { |product, quantity| receipt.add_product(product, quantity: quantity) }
puts Calculator::ReceiptFormatter.format(receipt)

# Example Usage 
receipt = Calculator::Receipt.new

products = [
  [Calculator::Product.new(name: "perfume", base_price: 27.99, type: :other, imported: true),1],
  [Calculator::Product.new(name: "perfume", base_price: 18.99, type: :other, imported: false),1],
  [Calculator::Product.new(name: "headache pills", base_price: 9.75, type: :medical, imported: false),1],
  [Calculator::Product.new(name: "chocolate", base_price: 11.25, type: :food, imported: true),3]]

products.each { |product, quantity| receipt.add_product(product, quantity: quantity) }
puts Calculator::ReceiptFormatter.format(receipt)