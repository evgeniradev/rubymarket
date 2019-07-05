# frozen_string_literal: true

require 'rails_helper'
require_relative '../../../rules/pricing_rules'

RSpec.describe PricingRules do
  subject { described_class.new(items) }

  let(:items) { [] }

  it 'returns an instance of BigDecimal' do
    expect(subject.total.class).to eq(BigDecimal)
  end

  it 'adds items to total' do
    3.times { items << create_item(:gr1) }

    expect('%.2f' % subject.total).to eq('9.33')
  end

  it '#find_price - raises error if items not identical' do
    items = [create_item(:gr1), create_item(:sr1)]

    expect { subject.send(:find_price, items) }.to(
      raise_error('Items must be identical')
    )
  end
end
