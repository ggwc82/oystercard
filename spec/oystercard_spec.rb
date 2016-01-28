require 'oystercard'

RSpec.describe OysterCard do

subject(:oystercard) { described_class.new }

let(:station) {double :station}
let(:station2) {double :station2}

  it 'has a balance of zero' do
  	expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it 'adds amount to balance' do
    expect{subject.top_up(1)}.to change{subject.balance}.by 1
    end
  end

context "----touching in and out ----" do

    it 'requires minimum balance' do
     expect{subject.touch_in(station)}.to raise_error 'Balance too low.'
    end

  describe '#touch_in' do

    it 'cannot touch in unless minimum balance met' do
      maximum_balance = OysterCard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      message = "error balance greater than maximum balance"
      expect{ subject.top_up(1) }.to raise_error (message)
    end
  end

  describe '#touch_out' do

    it 'charges for journey' do
 	  subject.top_up(1)
 	  subject.touch_in(station)
 	  expect {subject.touch_out(station2)}.to change{subject.balance}.by(-OysterCard::MINIMUM_CHARGE)
    end
  end
end

context "----journeys----" do


  describe '#previous_journeys' do
    it 'has default is empty' do
      expect(subject.previous_journeys).to eq ({})
    end

  end

  describe '#journeys' do
    it 'responds' do
      expect(subject).to respond_to(:journeys)
    end

    it 'returns an empty array' do
      expect(subject.journeys).to eq([])
    end

    it 'returns an array with 1 journey/hash' do
      subject.top_up(1)
      subject.touch_in(station)
      subject.touch_out(station2)
      expect(subject.journeys).to eq([{'entry_station' => station, 'exit_station' => station2}])
    end
  end
end















end
