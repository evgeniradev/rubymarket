# frozen_string_literal: true

require_relative '../../models/item'

module ItemFactory
  def create_item(item_name)
    method_name = "create_item_#{item_name}".to_sym
    raise 'Item factory missing' unless private_methods.include?(method_name)

    send(method_name)
  end

  private

  def create_item_gr1
    Item.new(code: 'GR1', name: 'Green tea', price: 3.11)
  end

  def create_item_sr1
    Item.new(code: 'SR1', name: 'Strawberries', price: 5.00)
  end

  def create_item_cf1
    Item.new(code: 'CF1', name: 'Coffee', price: 11.23)
  end

  def create_item_random
    Item.new(code: 'CF1', name: 'Coffee', price: 1)
  end
end
