require 'station'

describe Station do 

  subject(:station){described_class.new(name: "Bond Street", zone: 1)}

  describe '#name' do
    it 'returns station name' do
      expect(station.name).to eq("Bond Street")
    end
  end

  describe '#zone' do
    it 'returns station zone' do
      expect(station.zone).to eq(1)
    end
  end
end