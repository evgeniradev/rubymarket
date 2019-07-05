# frozen_string_literal: true

require_relative 'models/item'
require_relative 'rules/pricing_rules'

class Checkout
  def initialize(pricing_rules = PricingRules)
    validate_pricing_rules(pricing_rules)

    @pricing_rules = pricing_rules
    @items = []
  end

  def scan(item)
    validate_item(item)

    @items << item
  end

  def total
    add_gbp_sign('%.2f' % pricing_rules.new(items).total)
  end

  private

  def add_gbp_sign(amount)
    "£#{amount}"
  end

  def validate_item(item)
    raise 'Not a valid item' unless item.instance_of?(Item)
  end

  def validate_pricing_rules(pricing_rules)
    return if pricing_rules.ancestors.include?(PricingRules)

    raise 'pricing_rules must inherit from PricingRules'
  end

  attr_reader :items, :pricing_rules
end
