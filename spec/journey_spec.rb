require 'journey'

describe Journey do
  let(:one_journey) { {entry_station: :bank, exit_station: :cannon_st} }
  subject(:journey) {described_class.new }
  let(:card) {double :card}
  let(:station1) {double :station}
  let(:station2) {double :station}

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

  describe '#fare' do
    it 'defaults to #{PENALTY}' do
      expect(journey.fare).to eq Journey::PENALTY
    end


  end

  describe '#complete?' do
    it 'is default set to false' do
      expect(journey.complete?).to eq false
    end

    it 'returns true after passing entry and exit gates' do
      journey.entry(station1)
      journey.exit(station2)
      expect(journey.complete?).to eq true
    end

    context "journey complete" do
      it "charges #{Journey::PENALTY} fare if entry_station is nil" do
        journey.entry()
        journey.exit(station2)
        expect(journey.fare).to eq Journey::PENALTY
      end

      it "charges #{Journey::PENALTY} fare if exit_station is nil" do
        journey.entry(station1)
        journey.exit()
        expect(journey.fare).to eq Journey::PENALTY
      end

      it 'charges minimum fare when both entry and exit stations specified' do
        journey.entry(station1)
        journey.exit(station2)
        expect(journey.fare).to eq Journey::MINIMUM_CHARGE
      end
    end
  end

end