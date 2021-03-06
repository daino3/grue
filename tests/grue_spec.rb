require 'rspec'
require_relative '../models/grue'

describe Grue do
  let(:grue) { Grue.new(8)}

  it 'is initialized with a number of gems' do
    expect(grue.gems.count).to eq(8)
  end

  describe '#total_grue_worth' do
    it 'calculates how much the grue\'s gems are worth' do
      expect(grue.gem_worth).to eq(grue.gems.map(&:worth).inject(:+))
    end
  end

end