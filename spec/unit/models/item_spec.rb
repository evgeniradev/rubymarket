# frozen_string_literal: true

require 'rails_helper'
require_relative '../../../models/item'

RSpec.describe Item do
  subject { described_class }

  it '#validate_code - must be a String' do
    expect { subject.new(code: 1, name: 'name', price: 1) }.to(
      raise_error('Code must be a String')
    )
  end

  it '#validate_code - cannot be blank' do
    expect { subject.new(code: '', name: 'name', price: 1) }.to(
      raise_error('Code cannot be blank')
    )
  end

  it '#validate_name - cannot be blank' do
    expect { subject.new(code: 'code', name: '', price: 1) }.to(
      raise_error('Name cannot be blank')
    )
  end

  it '#validate_price' do
    expect { subject.new(code: 'code', name: 'name', price: 'Invalid') }.to(
      raise_error('Price must be an instance of Fixnum or Float')
    )
  end

  context '#eql?' do
    it 'true' do
      item1 =  subject.new(code: 'code', name: 'name1', price: 1)
      item2 =  subject.new(code: 'code', name: 'name2', price: 1)

      expect(item1.send(:eql?, item2)).to be_truthy
    end

    it 'false(different code)' do
      item1 =  subject.new(code: 'code1', name: 'name1', price: 1)
      item2 =  subject.new(code: 'code2', name: 'name2', price: 1)

      expect(item1.send(:eql?, item2)).to be_falsey
    end

    it 'false(different price)' do
      item1 =  subject.new(code: 'code', name: 'name1', price: 1)
      item2 =  subject.new(code: 'code', name: 'name2', price: 2)

      expect(item1.send(:eql?, item2)).to be_falsey
    end
  end
end
