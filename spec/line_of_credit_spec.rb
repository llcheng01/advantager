require 'spec_helper'

describe LineOfCredit do
  before do
    @today = DateTime.strptime('2015/08/17', "%Y/%m/%d")
    allow(Time).to receive(:now).and_return(@today)
    @credit = LineOfCredit.new
  end

  describe '#initialize' do
    it 'should set default credit, apr, payment period and start day' do
      expect(@credit.start_year).to eq 2015
      expect(@credit.start_day).to eq 17
      expect(@credit.start_month).to eq 8
      expect(@credit.transactions.size).to eq 12
    end
  end

  describe '#days_since_last_transaction' do
    it 'should return zero if there is no transactions' do
      expect(@credit.days_since_last_transaction 4).to eq 0
    end
    it 'should return the largest days since from all transactions' do
      @credit.transactions[7] << LineOfCredit::Line.new(3, 7, 100.00)
      @credit.transactions[7] << LineOfCredit::Line.new(15, 7, -100.00)
      @credit.transactions[7] << LineOfCredit::Line.new(20, 7, 75.00)
      
      expect(@credit.days_since_last_transaction 7).to eq 20
    end
  end

  describe '#withdraw' do
    it 'should raise error when withdraw more than balance' do
      @credit.withdraw(600.00, 5, 20)
      expect{@credit.withdraw(600.00, 5, 25)}.to raise_error(ArgumentError)
    end

    it 'should reduce balance to correct amount' do
      @credit.withdraw(300, 5, 28)
      expect(@credit.balance).to eq 300.00
      expect(@credit.transactions[5].size).to eq 1
      expect(@credit.transactions[5].first.amount).to eq 300
    end
  end
  
  describe '#deposit' do
    it 'should raise error when withdraw more than balance' do
      expect{@credit.deposit(600.00, 5, 25)}.to raise_error(ArgumentError)
    end

    it 'should reduce balance to correct amount' do
      @credit.withdraw(600.00, 5, 20)
      @credit.deposit(400, 5, 28)
      expect(@credit.balance).to eq 200.00
      expect(@credit.transactions[5].size).to eq 2
      expect(@credit.transactions[5][1].amount).to eq -400
    end
  end


  describe '#calculate_interest' do
    it 'should return interest for the current transaction for no previous transaction' do
      expect(@credit.calculate_interest 300, 15).to eq 4.32
    end
  end

  describe '#monthly_interest' do
    it 'should be zero interest if no transactions' do
      expect(@credit.monthly_interest 5).to eq 0
    end

    it 'should calculate interest for just one transactions' do
      # Scenario 1
      @credit.withdraw(500, 5, 1)
      expect(@credit.monthly_interest 5).to eq 14.38
    end

    it 'should calculate interest from principle and all the transactions for a specific month' do
      # Scenario 2
      @credit.withdraw(500, 5, 1)
      @credit.deposit(200, 5, 15)
      @credit.withdraw(100, 5, 25)
      expect(@credit.monthly_interest 5).to eq 11.99
    end
  end

  describe '#monthly_payment' do
    it 'should calculate correct monthly_payment for Scenario 1' do
      # Scenario 1
      @credit.withdraw(500, 5, 1)
      expect(@credit.monthly_payment 5).to eq 514.38
    end
    it 'should calculate correct monthly_payment' do
      @credit.withdraw(500, 5, 1)
      @credit.deposit(200, 5, 15)
      @credit.withdraw(100, 5, 25)
      expect(@credit.monthly_payment 5).to eq 411.99
    end
  end
end
