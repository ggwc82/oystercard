require 'oystercard'

describe OysterCard do
  subject(:card) { OysterCard.new }

  let(:station) { double :station }

  describe '#top_up' do
    it 'responds to #top_up with 1 argument' do
      expect(card).to respond_to(:top_up).with(1).argument
    end

    it 'adds the argument value to existing balance' do
      expect{card.top_up(10.00)}.to change{card.balance}.by(10.00)
    end

    it "raises an error when trying to add more than #{OysterCard::LIMIT}" do
      expect{card.top_up(100.00)}.to raise_error "Warning! Cannot add more than #{OysterCard::LIMIT}"
    end
  end

  describe '#balance' do
    it 'returns a balance' do
      expect(card.balance).to eq 0
    end
  end

  describe '#in_journey?' do
    it 'returns boolean and is false by default' do
      expect(card).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'changes state of in_journey to be true' do
      card.top_up(1.00)
      card.touch_in(station)
      expect(card).to be_in_journey
    end

    it "can't touch_in if below minimum_balance" do
      expect{card.touch_in(station)}.to raise_error("minimum balance not met")
    end

    it 'stores entry station' do
      card.top_up 1
      expect{card.touch_in(station)}.to change{card.entry_station}.to eq station
    end

  end

  describe '#touch_out' do

    before do
      card.top_up 1
      card.touch_in(station)
    end

    it 'changes state of in_journey to be false' do
      expect{card.touch_out}.to change{card.in_journey?}.to eq false
    end

    it 'charges card when touching out' do
      expect{card.touch_out}.to change{card.balance}.by -OysterCard::MINIMUM_BALANCE
    end

    it 'sets entry station to nil' do
      expect{card.touch_out}.to change{card.entry_station}.to eq nil
    end

  end


end
