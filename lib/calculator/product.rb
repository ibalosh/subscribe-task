module Calculator
  module ProductTypeValidator
    TYPES = {
      food: "Food",
      book: "Book",
      medical: "Medical",
      electronics: "Electronics",
      other: "Other"
    }.freeze

    EXEMPT_TYPES = %i[food medical book].freeze

    def self.valid?(type)
      TYPES.key?(type)
    end

    def self.human_readable(type)
      TYPES[type]
    end

    def self.validate!(type)
      raise "Invalid product type #{type}" unless valid?(type)
    end

    def self.exempt?(type)
      EXEMPT_TYPES.include?(type)
    end
  end

  class Product
    attr_reader :name, :base_price, :type, :imported

    def initialize(name: , base_price:, imported: , type: :other)
      ProductTypeValidator.validate!(type)

      @name = name
      @base_price = base_price
      @type = type
      @imported = imported
    end
  end
end