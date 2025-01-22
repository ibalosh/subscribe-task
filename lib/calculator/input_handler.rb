require_relative 'product.rb'
require_relative 'tax_calculator'
require_relative 'receipt'
require_relative 'receipt/formatter'
require_relative 'input_parser'

module Calculator
  # Sole purpose of this handle class is to handle input of products by user, and printing out the result.
  class InputHandler
    def initialize(receipt)
      @receipt = receipt
    end

    def start
      puts "Enter items in the format: '<quantity> <name> at <price> [product type] [imported]'\n\n"
      puts "Product type and imported word are optional."
      puts "Product can be: book, food, medical, etc."
      puts "Example: 1 banana at 10.29 food imported"
      puts "\n\nType 'done' when finished."

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