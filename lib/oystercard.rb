class OysterCard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  attr_reader :balance, :journeys, :journey
  attr_accessor :in_journey

  def initialize
    @balance = 0 
    @journeys = []
    @journey = {}
  end

  def top_up(amount)
    raise "error balance greater than #{MAXIMUM_BALANCE}" if exceed_balance?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient balance" if insufficient_balance?
    journey[:entry_station] = station
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    journey[:exit_station] = station
    journeys << journey
    @journey = {}
  end

  def in_journey?
    journey.count == 1
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