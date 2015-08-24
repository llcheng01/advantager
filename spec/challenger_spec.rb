require 'spec_helper'

describe Challenger do
  before(:each) do
    @challenger = Challenger.new [10, 5, 2, 20], "cache.yml"
  end

  describe '#substring' do
    it 'return empty array for array size 0 or 1' do
      expect(@challenger.substring(50, []).size).to eq 0
      expect(@challenger.substring(50, [50]).size).to eq 0
    end

    it 'return correct array for array size is 2' do
      r = @challenger.substring(50, [50, 10])
      expect(r.size).to eq 1
      expect(r).to eq [10]
      
    end

    it 'return array without the first element' do
      r = @challenger.substring(50, [50, 2, 10])
      expect(r.size).to eq 2
      expect(r).to eq [2,10]
    end

    it 'return array without the last element' do
      r = @challenger.substring(10, [50, 2, 10])
      expect(r.size).to eq 2
      expect(r).to eq [50,2]
    end

    it 'return array without source element' do
      r = @challenger.substring(2, [50, 2, 10])
      expect(r.size).to eq 2
      expect(r).to eq [50,10]
    end
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

  describe '#calculate_factors' do
    it 'should return hash of input with factors as array for each input' do
      result = {10=>[2,5], 5=>[], 2=> [], 20=>[2,5,10]}
      expect(@challenger.calculate_factors).to eq result
    end
  end

  describe '#calculate_multipliers' do
    it 'should return hash of input with multipliers as array for each input' do
      result = {10=>[20], 5=>[20,10], 2=>[20,10], 20=>[]}
      expect(@challenger.calculate_multipliers).to eq result
    end
  end

  describe '#save_to_yaml' do
    it 'should be able to save result to yaml file' do
      data = @challenger.calculate_factors
      @challenger.save_to_yaml data
    end
  end

end
