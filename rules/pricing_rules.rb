# frozen_string_literal: true

require 'bigdecimal'

class PricingRules
  def initialize(items)
    @items = items
    @total = BigDecimal('0')
  end

  def total
    uniq_codes.each do |code|
      method_name = "#{code.downcase.to_sym}_rules".to_sym
      private_methods.include?(method_name) ? send(method_name) : no_rules(code)
    end

    @total
  end

  private

  attr_reader :items

  def no_rules(name)
    no_rules_items = obtain_item_group(name)
    @total += find_price(no_rules_items) * no_rules_items.length
  end

  def find_price(identical_items)
    single_item = identical_items.uniq

    raise 'Items must be identical' if single_item.length > 1

    single_item.first.price
  end

  def uniq_codes
    @uniq_codes ||= items.uniq.map(&:code)
  end

  def obtain_item_group(code)
    items.select { |item| item.code == code }
  end
end
