require 'station'

describe Station do
  
	subject(:station) {described_class.new(name: "temple", zone: 1)}

  describe '#station_name' do
  	it 'returns a station name' do
  		expect(station.station_name).to eq 'temple'
  	end

  	it 'returns a zone' do 
  		expect(station.zone).to eq 1
  	end
  end
end