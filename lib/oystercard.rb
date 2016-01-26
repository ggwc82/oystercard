class OysterCard
  Limit = 90.00
  MINIMUM_BALANCE = 1.00

  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(money)
    raise "Warning! Cannot add more than #{Limit}" if new_balance?(money)
    @balance += money
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise "minimum balance not met" if min_balance?
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_BALANCE)
    @in_journey = false
  end

  private

  def deduct(fare)
    @balance -= fare
  end

  def new_balance?(money)
    (@balance + money) > Limit
  end

  def min_balance?
    @balance < MINIMUM_BALANCE
  end
end
