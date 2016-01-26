class OysterCard
  Limit = 90.00

  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(money)
    raise "Warning! Cannot add more than #{Limit}" if new_balance(money) > Limit
    @balance = new_balance(money)
  end

  def new_balance(money)
    @balance + money
  end

  def deduct(fare)
    @balance -= fare
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end
