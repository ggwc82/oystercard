class OysterCard
  LIMIT = 90.00
  MINIMUM_BALANCE = 1.00


  attr_reader :balance, :entry_station, :journeys, :exit_station

  def initialize
    @balance = 0
    @journeys = []
    @journey = {}
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
    @journey[:entry_station] = station
  end

  def touch_out(station)
    deduct(MINIMUM_BALANCE)
    @exit_station = station
    @journey[:exit_station] = station
    @journeys << @journey
    @journey = {} #we current haven't got a unit test for this!
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
