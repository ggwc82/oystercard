
class OysterCard

 MAXIMUM_BALANCE = 90
 MINIMUM_BALANCE = 1
 MINIMUM_CHARGE = 1

 attr_reader :balance, :previous_journeys, :journeys, :history
 
 def initialize
   @balance = 0
   @previous_journeys = {}
   @journeys = []
   @history = Journey.new
 end

 def top_up(amount)
 	raise "error balance greater than maximum balance" if exceed_balance?(amount)
 	@balance += amount
 end

 def touch_in(entry_station)
 	raise 'Balance too low.' if below_min_balance?
  @previous_journeys.merge!({entry_station: entry_station})
end

def touch_out(exit_station)
  deduct(MINIMUM_CHARGE)
  @previous_journeys.merge!({exit_station: exit_station})
  add_journey_to_array
  @previous_journeys = {}
end


private

def add_journey_to_array
  @history.import(@previous_journeys)
  #@journeys << @previous_journeys
end

def deduct(amount)
  @balance -= amount
end

def exceed_balance?(amount)
  balance + amount > MAXIMUM_BALANCE
end

def below_min_balance?
  balance < MINIMUM_BALANCE
end
end