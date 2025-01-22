module Calculator
  class InputParser
    def self.parse(input)
      match = input.match(/(\d+)\s+(.+)\s+at\s+([\d.]+)\s+(\w+)(\s+imported)?/)
      raise "Invalid input format" unless match

      {
        quantity: match[1].to_i,
        name: match[2].strip,
        base_price: match[3].to_f,
        type: match[4].to_sym,
        imported: !match[5].nil?
      }
    end
  end
end