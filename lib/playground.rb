require_relative 'calculator/receipt'
require_relative 'calculator/receipt/formatter'
require_relative 'calculator/product'

# In this file, you can see some of the examples for the calculator in action, for different product types, prices taxes.
# Couple of example usages of the calculator with predefined products, can be seen below.

# EXAMPLE 1
receipt = Calculator::Receipt.new(Calculator::TaxCalculator.new)

products = [
  [Calculator::Product.new(name: "book", base_price: 12.49, type: :book, imported: false),2],
  [Calculator::Product.new(name: "music", base_price: 14.99, type: :other, imported: false),1],
  [Calculator::Product.new(name: "chocolate", base_price: 0.85, type: :food, imported: false),1]
]

products.each { |product, quantity| receipt.add_product(product, quantity: quantity) }
puts Calculator::Receipt::Formatter.format(receipt)

# EXAMPLE 2
receipt = Calculator::Receipt.new(Calculator::TaxCalculator.new)

products = [
  [Calculator::Product.new(name: "chocolate", base_price: 10.00, type: :food, imported: true),1],
  [Calculator::Product.new(name: "perfume", base_price: 47.50, type: :other, imported: true),1]]

products.each { |product, quantity| receipt.add_product(product, quantity: quantity) }
puts Calculator::Receipt::Formatter.format(receipt)

# EXAMPLE 3
receipt = Calculator::Receipt.new(Calculator::TaxCalculator.new)

products = [
  [Calculator::Product.new(name: "perfume", base_price: 27.99, type: :other, imported: true),1],
  [Calculator::Product.new(name: "perfume", base_price: 18.99, type: :other, imported: false),1],
  [Calculator::Product.new(name: "headache pills", base_price: 9.75, type: :medical, imported: false),1],
  [Calculator::Product.new(name: "chocolate", base_price: 11.25, type: :food, imported: true),3]]

products.each { |product, quantity| receipt.add_product(product, quantity: quantity) }
puts Calculator::Receipt::Formatter.format(receipt)