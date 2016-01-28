class OysterCard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  attr_reader :balance, :journeys, :journey

  def initialize
    @balance = 0 
    @journeys = Journey.new
    @journey = journeys.current
  end

  def top_up(amount)
    raise "error balance greater than #{MAXIMUM_BALANCE}" if exceed_balance?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient balance" if insufficient_balance?
    journeys.entry(station)
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    journeys.exit(station)
  end

  def in_journey?
    journeys.in_transit?
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def exceed_balance?(amount)
    balance + amount > MAXIMUM_BALANCE
  end

  def insufficient_balance?
    @balance < MINIMUM_BALANCE
  end
end