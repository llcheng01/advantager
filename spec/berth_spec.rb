require 'spec_helper'

describe Berth do
  before(:each) do
    @berth = Berth.new
  end

  describe '#initialize' do
    it 'should create data directories for factors and multiplier if not exist' do
      
    end
    it 'should load available factors or multipliers as string arrays' do
      
    end
  end

  describe '#factor_exist?' do
    it 'should return true if basename of cache exist' do
      
    end

    it 'should return false if basename of cache does not exist' do
      
    end
  end

  describe '#convert_to_key' do
    it 'should convert integer array into appropriate name' do
      input = [10, 2, 5, 50, 30]
      expect(@berth.convert_to_key(input)).to eql '2-5-10-30-50'
    end
  end

  describe '#create_cache' do
    it 'should create cache file or overwrite it' do
      
    end
  end
  
  describe '#list_cache' do
    it 'should list available cache file name' do
      
    end
  end
end
