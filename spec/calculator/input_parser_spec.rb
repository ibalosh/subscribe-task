require_relative '../../lib/calculator/input_handler'

RSpec.describe Calculator::InputHandler do
  let(:receipt) { Calculator::Receipt.new(Calculator::TaxCalculator.new) }
  let(:input_handler) { described_class.new(receipt) }

  before do
    # Suppress input and printing in input handler by stubbing
    allow(input_handler).to receive(:puts)
    allow(input_handler).to receive(:print)
  end

  describe '#start' do
    it 'adds products to the receipt' do
      input_sequence = ['2 PRODUCT1 NAME at 15.10 book', '1 PRODUCT2 NAME at 0.50 food', 'done']
      allow(input_handler).to receive(:gets).and_return(*input_sequence)

      aggregate_failures "receipt verification" do
        expect { input_handler.start }.to change { receipt.products.count }.by(2)
        expect(receipt.products[0][:product].name).to eq('PRODUCT1 NAME')
        expect(receipt.products[0][:product].base_price).to eq(15.10)
        expect(receipt.products[1][:product].name).to eq('PRODUCT2 NAME')
        expect(receipt.products[1][:product].base_price).to eq(0.50)
      end
    end

    it 'displays an error message for invalid input' do
      input_sequence = ['INVALID INPUT','done']
      allow(input_handler).to receive(:gets).and_return(*input_sequence)

      expect(input_handler).to receive(:puts).with(/Error: Invalid input format/).once
      expect { input_handler.start }.to change { receipt.products.count }.by(0)
    end

    it 'does not add any products to the receipt' do
      input_sequence = ['done']
      allow(input_handler).to receive(:gets).and_return(*input_sequence)

      expect { input_handler.start }.not_to change { receipt.products.count }
    end
  end
end