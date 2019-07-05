# frozen_string_literal: true

require_relative 'factories/item_factory'

RSpec.configure do |config|
  config.include ItemFactory
end
