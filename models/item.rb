# frozen_string_literal: true

require 'bigdecimal'

class Item
  def initialize(code:, name:, price:)
    validate_code(code)
    validate_name(name)
    validate_price(price)

    @code = code
    @name = name
    @price = BigDecimal(price.to_s)
  end

  attr_reader :code, :name, :price

  private

  def hash
    "#{code}_#{price}".hash
  end

  def eql?(other)
    "#{code}_#{price}" == "#{other.code}_#{other.price}"
  end

  %i[code name].each do |attr_name|
    define_method "validate_#{attr_name}" do |arg|
      attr_caps = attr_name.capitalize

      raise("#{attr_caps} must be a String") unless arg.instance_of?(String)

      raise("#{attr_caps} cannot be blank") if arg.length.zero?
    end
  end

  def validate_price(price)
    return if price.instance_of?(Fixnum) || price.instance_of?(Float)

    raise 'Price must be an instance of Fixnum or Float'
  end
end
