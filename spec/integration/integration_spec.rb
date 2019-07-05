# frozen_string_literal: true

require 'rails_helper'
require_relative '../../checkout'
require_relative '../../rules/main_pricing_rules'

RSpec.describe Checkout do
  it '#total' do
    subject = described_class.new(MainPricingRules)
    subject.scan(create_item(:gr1))
    subject.scan(create_item(:cf1))
    subject.scan(create_item(:sr1))
    subject.scan(create_item(:cf1))
    subject.scan(create_item(:cf1))

    expect(subject.total).to eq('£30.57')
  end
end
