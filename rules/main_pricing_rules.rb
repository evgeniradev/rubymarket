# frozen_string_literal: true

require_relative 'pricing_rules'

class MainPricingRules < PricingRules
  private

  # Green Tea
  def gr1_rules
    gr1_items = obtain_item_group('GR1')
    price = find_price(gr1_items)

    @total += (price * (gr1_items.length / 2.0).ceil)
  end

  # Strawberries
  def sr1_rules
    sr1_items = obtain_item_group('SR1')
    sr1_items_length = sr1_items.length
    price = find_price(sr1_items)

    price = BigDecimal('4.5') if sr1_items_length >= 3

    @total += (price * sr1_items_length)
  end

  # Coffee
  def cf1_rules
    cf1_items = obtain_item_group('CF1')
    cf1_items_length = cf1_items.length
    price = find_price(cf1_items)

    price *= (2 / 3.0) if cf1_items_length >= 3

    @total += (price * cf1_items_length)
  end
end
