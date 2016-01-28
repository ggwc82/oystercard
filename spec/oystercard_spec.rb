require 'oystercard'

describe OysterCard do

  subject(:oystercard) { described_class.new }
  let(:station) {double :station}
  let(:station2) {double :station2}

  it 'has a balance of zero' do
  	expect(oystercard.balance).to eq(0)
  end

  describe '#top_up' do
    it 'adds amount to balance' do
      expect{oystercard.top_up(1)}.to change{oystercard.balance}.by 1
    end
  end

  context "----touching in and out ----" do

    it 'requires minimum balance' do
     expect{oystercard.touch_in(station)}.to raise_error 'Balance too low.'
   end

   describe '#touch_in' do
    it 'cannot touch in unless minimum balance met' do
      maximum_balance = OysterCard::MAXIMUM_BALANCE
      oystercard.top_up(maximum_balance)
      message = "error balance greater than maximum balance"
      expect{ oystercard.top_up(1) }.to raise_error (message)
    end
  end

  describe '#touch_out' do

    it 'charges for journey' do
      oystercard.top_up(1)
      oystercard.touch_in(station)
      expect {oystercard.touch_out(station2)}.to change{oystercard.balance}.by(-OysterCard::MINIMUM_CHARGE)
    end
  end
end

context "----journeys----" do


  describe '#previous_journeys' do
    it 'has default is empty' do
      expect(oystercard.previous_journeys).to eq ({})
    end
  end

  describe '#journeys' do

    it 'returns an empty array' do
      expect(oystercard.journeys).to eq([])
    end

    it 'returns an array with 1 journey/hash' do
      oystercard.top_up(1)
      oystercard.touch_in(station)
      oystercard.touch_out(station2)
      expect(oystercard.journeys).to eq([{entry_station: station, exit_station: station2}])
    end
  end
end















end
