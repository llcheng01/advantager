require 'date'

class LineOfCredit
  attr_accessor :start, :transactions, :balance

  # Assume closing day is the 1st of the month
  COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  MAX_CREDIT = 1000.00
  APR = 0.35
  PERIOD = 30

  def initialize
    @start = Time.now
    @transactions = (1..12).inject({}) {|h,d| h[d] = []; h}
    @balance = 0
  end

  # check if credit is sufficient
  # Calculate days from last transaction
  # deduct amount from credit
  def withdraw amount, month, day
    raise ArgumentError, 'Insufficient credit!' if amount + @balance > MAX_CREDIT
    # create transaction entry
    @transactions[month] << Line.new(day, month, amount)
    @balance += amount
  end

  def deposit amount, month, day
    raise ArgumentError, 'Deposit more than Max credit of 1000.00' if @balance - amount < 0
    # create transaction entry
    @transactions[month] << Line.new(day, month, -amount)
    @balance -= amount
  end

  def days_since_last_transaction month
    lines = @transactions[month]
    return 0 if lines.empty?
    last_line = lines.max {|a, b| a.day_from <=> b.day_from }
    last_line.day_from
  end

  # Get last transaction and current credit
  def calculate_interest principle, days_since
    (principle * APR / 365 * days_since).round(2)
  end

  def monthly_interest month
    num_of_transactions = @transactions[month].size
    transactions = @transactions[month]
    interest = 0
    i = 0
    principle = 0
    return 0 if num_of_transactions == 0

    while i < num_of_transactions do
      principle = principle + transactions[i].amount
      # handle first day as zero index
      offset = transactions[i].day_from == 1? 1 : 0

      # last transactions
      if num_of_transactions == 1
        term = PERIOD - transactions[i].day_from + offset
      elsif i == num_of_transactions - 1
        term = PERIOD - transactions[i].day_from
      else
        term = transactions[i + 1].day_from - transactions[i].day_from + offset
      end
      interest += calculate_interest principle, term
      i += 1
    end
    interest
  end

  def monthly_payment month
    @balance + monthly_interest(month)
  end

  def start_year
    @start.year
  end
  
  def start_day
    @start.day
  end
  
  def start_month
    @start.month
  end
end
# day when transaction occurs, month, interest to day
Line = Struct.new(:day_from, :month, :amount)
