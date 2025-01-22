module Calculator
  class Receipt
    class Formatter
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
  end
end
