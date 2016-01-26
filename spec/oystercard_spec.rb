require 'oystercard'

describe OysterCard do
  subject(:card) { OysterCard.new }

  describe '#top_up' do
    it 'responds to #top_up with 1 argument' do
      expect(card).to respond_to(:top_up).with(1).argument
    end

    it 'adds the argument value to existing balance' do
      expect{card.top_up(10.00)}.to change{card.balance}.by(10.00)
    end

    it "raises an error when trying to add more than #{OysterCard::Limit}" do
      expect{card.top_up(100.00)}.to raise_error "Warning! Cannot add more than #{OysterCard::Limit}"
    end
  end

  describe '#balance' do
    it 'returns a balance' do
      expect(card.balance).to eq 0
    end
  end

  describe '#deduct' do
    it 'deducts the passed amount from balance' do
      card.top_up(20.00)
      expect{card.deduct(10.00)}.to change{card.balance}.by(-10.00)
    end
  end

  describe '#in_journey?' do
    it 'returns boolean and is false by default' do
      expect(card).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'changes state of in_journey to be true' do
      card.touch_in
      expect(card).to be_in_journey
    end
  end

  describe '#touch_out' do
    it 'changes state of in_journey to be false' do
      card.touch_in
      expect{card.touch_out}.to change{card.in_journey?}.to eq false
    end
  end
end
