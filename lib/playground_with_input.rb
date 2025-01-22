require_relative 'calculator/input_handler'

# Example usage of the calculator by using custom input from the user
# Run this file if you want to try out the calculator with your own input
# The calculator will ask you to input the product details and then it will print the receipt
receipt = Calculator::Receipt.new(Calculator::TaxCalculator.new)
input_handler = Calculator::InputHandler.new(receipt)
input_handler.start

puts Calculator::Receipt::Formatter.format(receipt)
