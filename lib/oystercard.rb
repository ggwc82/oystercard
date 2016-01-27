

class OysterCard

 MAXIMUM_BALANCE = 90
 MINIMUM_BALANCE = 1

 MINIMUM_CHARGE = 1

 attr_reader :balance, :entry_station,  :previous_journeys
 attr_accessor :in_journey

 def initialize
   @balance = 0
   @in_journey = false
   @previous_journeys = {}
 end

 def top_up(amount)
 	raise "error balance greater than maximum balance" if balance + amount > MAXIMUM_BALANCE
 	@balance += amount
 end

 def touch_in(entry_station)
 	raise 'Balance too low.' if balance < MINIMUM_BALANCE
  @previous_journeys.merge!({'entry_station' => entry_station})
 	@in_journey = true
 end

 def touch_out(exit_station)
 	deduct(MINIMUM_CHARGE)
  @previous_journeys.merge!({'exit_station' => exit_station})
  @in_journey = false
 end

 private

 def deduct(amount)
 	@balance -= amount
 end









end