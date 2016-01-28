class Station

  def initialize(station)
    @station_name = station[:name]
    @zone = station[:zone]

  end

  attr_reader :station_name, :zone
  
end