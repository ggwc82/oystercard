class Journey
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

  def entry(station)
    current[:entry_station] = station
  end

  def exit(station)
    current[:exit_station] = station
    update
  end

end