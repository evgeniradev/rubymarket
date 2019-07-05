# frozen_string_literal: true

require 'rails_helper'
require_relative '../../checkout'
require_relative '../../rules/main_pricing_rules'

RSpec.describe Checkout do
  subject { described_class }

  it '#validate_pricing_rules' do
    expect { subject.new(Object) }.to(
      raise_error('pricing_rules must inherit from PricingRules')
    )
  end

  it '#validate_item' do
    expect { subject.new(MainPricingRules).scan('Invalid') }.to(
      raise_error('Not a valid item')
    )
  end

  it '#total - with a specified pricing_rules argument' do
    allow(MainPricingRules).to receive_message_chain(:new, :total).and_return(1)

    expect(subject.new(MainPricingRules).total).to eq('£1.00')
  end

  it '#total - without a specified pricing_rules argument' do
    allow(PricingRules).to receive_message_chain(:new, :total).and_return(1)

    expect(subject.new.total).to eq('£1.00')
  end
end
