require 'journey'

describe Journey do
  let(:one_journey) { {entry_station: :bank, exit_station: :cannon_st} }
  subject(:journey) {described_class.new }
  let(:card) {double :card}


  describe '#list' do
    it 'initially returns an empty array' do
      expect(journey.list).to eq([])
    end

    it 'returns an array with 1 journey' do
      journey.current = :one_journey
      journey.update
      expect(journey.list).to eq ([:one_journey])
    end
  end

  describe '#current' do
    it 'initially returns an empty hash' do
      expect(journey.current).to eq ({})
    end

  end
end