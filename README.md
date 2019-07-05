# Rubymarket

A Ruby-based application that allows users to add items to a basket and obtain the total amount based on rules.

## Installation

```
$ bundle install
```

Example usage:
```
require_relative 'checkout'
require_relative 'rules/main_pricing_rules'

checkout = Checkout.new(MainPricingRules)

green_tea = Item.new(code: 'GR1', name: 'Green tea', price: 3.11)
strawberries = Item.new(code: 'SR1', name: 'Strawberries', price: 5.00)
coffee = Item.new(code: 'CF1', name: 'Coffee', price: 11.23)

checkout.scan(green_tea)
checkout.scan(strawberries)
checkout.scan(coffee)

checkout.total
```

## Running the tests

```
$ bundle exec rspec
```
