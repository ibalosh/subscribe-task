module Calculator
  class TaxCalculator
    attr_reader :base_tax_rate, :import_tax_rate, :rounding_factor

    DEFAULTS  = {
      BASE_TAX_RATE: 0.10,
      IMPORT_TAX_RATE: 0.05,
      ROUNDING_FACTOR: 0.05
    }

    # @param base_tax_rate [Float] The base tax rate
    # @param import_tax_rate [Float] The import tax rate
    # @param rounding_factor [Float] The rounding factor
    # @param product_types_exempt_from_tax [Array<Symbol>] The product types exempt from tax
    def initialize(
      base_tax_rate: DEFAULTS[:BASE_TAX_RATE],
      import_tax_rate: DEFAULTS[:IMPORT_TAX_RATE],
      rounding_factor: DEFAULTS[:ROUNDING_FACTOR],
      product_types_exempt_from_tax: %i[food medical book]
    )
      @base_tax_rate = base_tax_rate
      @import_tax_rate = import_tax_rate
      @rounding_factor = rounding_factor
      @product_types_exempt_from_tax = product_types_exempt_from_tax
    end

    # @param product [Product] The product to calculate tax for
    # @return [Float] The calculated tax
    def calculate(product)
      tax = 0
      tax += product.base_price * base_tax_rate unless exempt?(product.type)
      tax += product.base_price * import_tax_rate if product.imported

      round_up(tax)
    end

    private

    # @param type [Symbol] the product type to check
    # @return [Boolean] Whether the product type is exempt from tax
    def exempt?(type)
      @product_types_exempt_from_tax.include?(type)
    end

    # @param value [Float] The value to round up
    # @return [Float] The rounded up value
    def round_up(value)
      (value / rounding_factor).ceil * rounding_factor
    end
  end
end