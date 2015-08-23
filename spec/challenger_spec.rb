require 'spec_helper'

describe Challenger do
  before(:each) do
    @challenger = Challenger.new
  end

  describe '#factors' do
    it 'return empty array if target is empty' do
      expect(@challenger.factors(50, [], [])).to eq []
    end
    it 'return array of integers that are factors of the source' do
      expect(@challenger.factors(50, [5, 10, 2, 7], [])).to eq [2,10,5]
    end
    it 'return empty array when none of the integers in the array is factor of the source' do
      expect(@challenger.factors(50, [7, 13], [])).to eq []
    end
  end

  describe '#multipliers' do
    it 'return array of integers that are multipliers of the source' do
      expect(@challenger.multipliers(2, [10, 5, 20], [])).to eq [20, 10]
    end

    it 'return empty array when none of the integers in the array is multiplier of the source' do
      expect(@challenger.multipliers(3, [10, 5, 20], [])).to eq []
    end
  end

end
