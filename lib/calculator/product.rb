module Calculator
  class Product
    attr_reader :name, :base_price, :type, :imported

    def initialize(name: , base_price:, imported: , type: :other)
      @name = name
      @base_price = base_price
      @type = type
      @imported = imported
    end
  end
end