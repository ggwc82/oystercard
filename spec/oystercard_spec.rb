require 'oystercard'

describe OysterCard do
  let(:entry_station){double :station}
  let(:exit_station){double :station}
  let(:journey1){ {entry_station: entry_station, exit_station: exit_station} }
  let(:journey2){ {entry_station: exit_station, exit_station: entry_station} }
  subject(:card) { described_class.new }

  it 'has a balance of zero' do
    expect(card.balance).to eq(0)
  end


  describe '#top_up' do
    it 'adds amount to balance' do
      expect{card.top_up(1)}.to change{card.balance}.by 1
    end

    it 'raises an error when balance greater than limit' do
      maximum_balance = OysterCard::MAXIMUM_BALANCE
      card.top_up(maximum_balance)
      expect{ card.top_up(1) }.to raise_error "error balance greater than #{maximum_balance}"
    end
  end

  describe '#deduct' do
    it 'deducts the minimum' do
      min_charge = OysterCard::MINIMUM_CHARGE
      card.top_up(10)
      card.touch_in(entry_station)
      expect{card.touch_out(exit_station)}.to change{card.balance}.by -(min_charge)
    end
  end

  describe '#touch_in' do
    it 'it touches in' do
      card.top_up(1)
      card.touch_in(entry_station)
      expect(card).to be_in_journey
    end

    it 'returns error:insufficient balance' do
      expect{card.touch_in(entry_station)}.to raise_error "Insufficient balance"
    end

  end

  describe '#touch_out' do
    it 'touches out' do
      card.top_up(1)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card).not_to be_in_journey
    end
  end

  describe '#in_journey?' do
    before(:each) { card.top_up(1) }

    it 'returns true when in journey' do
      card.touch_in(entry_station)
      expect(card).to be_in_journey
    end   

    it 'returns false initially' do
      expect(card).not_to be_in_journey
    end
  end

  describe '#journeys' do
    it 'initially be an empty array' do
      expect(card.journeys).to eq []
    end

    it 'lists journies' do
      card.top_up(10)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      card.touch_in(exit_station)
      card.touch_out(entry_station)
      expect(card.journeys).to eq([journey1, journey2])
    end
  end

  describe '#journey' do
    it 'initially be an empty hash' do
      expect(card.journey).to be_instance_of Hash
    end
  end
end
















