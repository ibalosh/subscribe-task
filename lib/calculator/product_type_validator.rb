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

    # @return [Boolean] true if the type is valid
    def self.valid?(type)
      TYPES.key?(type)
    end

    # @return [String] human readable type
    def self.human_readable(type)
      TYPES[type]
    end

    # @raise [RuntimeError] if the type is invalid
    def self.validate!(type)
      raise "Invalid product type #{type}" unless valid?(type)
    end

    # @return [Boolean] true if the type is exempt from taxes
    def self.exempt?(type)
      EXEMPT_TYPES.include?(type)
    end
  end
end