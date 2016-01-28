require 'journey'

describe Journey do
  let(:card) { double :oystercard}
  let(:station) { double :station}
  let(:station2) { double :station}
  subject(:journey) { described_class.new }

  describe '#journeys' do
    it 'returns an empty array' do
      expect(journey.list).to eq([])
    end
    
    it 'returns an array with 1 journey/hash' do
      allow(card).to receive(:top_up) #.with(1).argument 
      allow(card).to receive(:touch_in) #.with(1).argument
      allow(card).to receive(:touch_out) #.with(1).argument
      card.top_up(1)
      card.touch_in(station)
      card.touch_out(station2)
      journey.import({entry_station: station, exit_station: station2})
      expect(journey.list).to eq([{entry_station: station, exit_station: station2}])
    end
  end


end