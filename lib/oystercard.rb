class OysterCard
  LIMIT = 90.00
  MINIMUM_BALANCE = 1.00

  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
  end

  def top_up(money)
    raise "Warning! Cannot add more than #{LIMIT}" if new_balance?(money)
    @balance += money
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    raise "minimum balance not met" if min_balance?
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_BALANCE)
    @entry_station = nil
  end

  private

  def deduct(fare)
    @balance -= fare
  end

  def new_balance?(money)
    (@balance + money) > LIMIT
  end

  def min_balance?
    @balance < MINIMUM_BALANCE
  end
end
