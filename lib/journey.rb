class Journey

  PENALTY = 6
  MINIMUM_CHARGE = 1

  def initialize
    @list = []
    @current = {}
  end

  attr_reader :list
  attr_accessor :current

  def update
    list << current
    @current = {}
  end

  def in_transit?
    current.count == 1
  end

  def entry(station = nil)
    current[:entry_station] = station
  end

  def exit(station = nil)
    current[:exit_station] = station
  end

  def fare
    return MINIMUM_CHARGE if (!fare_dodger? && complete?)
    PENALTY
  end

  def complete?
    return true if current.has_key?(:exit_station)
    false
  end

  private

  def fare_dodger?
    current.has_value?(nil)
  end

end