# frozen_string_literal: true

require 'rails_helper'
require_relative '../../../checkout'
require_relative '../../../rules/main_pricing_rules'

RSpec.describe MainPricingRules do
  subject { '%.2f' % described_class.new(items).total }

  let(:items) { [] }

  it 'applies 2-4-1 discount to GR1' do
    3.times { items << create_item(:gr1) }

    expect(subject).to eq('6.22')
  end

  it 'reduces price of each SR1 to £4.5 if it is scanned 3 or more times' do
    3.times { items << create_item(:sr1) }

    expect(subject).to eq('13.50')
  end

  it 'reduces price of each CF1 to 2/3 if it is scanned 3 or more times' do
    3.times { items << create_item(:cf1) }

    expect(subject).to eq('22.46')
  end

  context 'Edge Cases' do
    it "returns 22.45 when basket contains 'GR1,SR1,GR1,GR1,CF1'" do
      items << create_item(:gr1)
      items << create_item(:sr1)
      items << create_item(:gr1)
      items << create_item(:gr1)
      items << create_item(:cf1)

      expect(subject).to eq('22.45')
    end

    it "returns 3.11 when basket contains 'GR1,GR1'" do
      items << create_item(:gr1)
      items << create_item(:gr1)

      expect(subject).to eq('3.11')
    end

    it "returns 16.61 when basket contains 'SR1,SR1,GR1,SR1'" do
      items << create_item(:sr1)
      items << create_item(:sr1)
      items << create_item(:gr1)
      items << create_item(:sr1)

      expect(subject).to eq('16.61')
    end

    it "returns 30.57 when basket contains 'GR1,CF1,SR1,CF1,CF1'" do
      items << create_item(:gr1)
      items << create_item(:cf1)
      items << create_item(:sr1)
      items << create_item(:cf1)
      items << create_item(:cf1)

      expect(subject).to eq('30.57')
    end
  end
end
