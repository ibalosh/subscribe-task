require_relative 'calculator/product'
require_relative 'calculator/tax_calculator'
require_relative 'calculator/product_type_validator'
require_relative 'calculator/receipt'
require_relative 'calculator/receipt_formatter'
require_relative 'input_parser'

module Calculator
  class InputHandler
    def initialize(receipt)
      @receipt = receipt
    end

    def start
      puts "Enter items in the format: '<quantity> <name> at <price> <type> [imported]'"
      puts "Type 'done' when finished."

      loop do
        print "Enter item (or write 'done' to finish): "
        input = gets.chomp
        break if input.downcase == 'done'

        begin
          parsed_input = InputParser.parse(input)
          update_receipt(parsed_input)
        rescue StandardError => e
          puts "Error: #{e.message}. Please try again."
        end
      end
    end

    private

    def update_receipt(parsed_input)
      product = Product.new(name: parsed_input[:name], base_price: parsed_input[:base_price], type: parsed_input[:type], imported: parsed_input[:imported])
      @receipt.add_product(product, quantity: parsed_input[:quantity])
      puts "Added: #{parsed_input[:quantity]} #{parsed_input[:name]} at #{parsed_input[:base_price]}"
    end
  end
end

# Example Usage
receipt = Calculator::Receipt.new(Calculator::TaxCalculator.new)
input_handler = Calculator::InputHandler.new(receipt)
input_handler.start

puts Calculator::ReceiptFormatter.format(receipt)