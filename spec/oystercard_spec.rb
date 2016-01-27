require 'oystercard'

describe OysterCard do
   let(:station){double :station}
  it 'has a balance of zero' do
  	expect(subject.balance).to eq(0)
  end

describe '#top_up' do
  it 'adds amount to balance' do
  expect{subject.top_up(1)}.to change{subject.balance}.by 1
 end 
end

it 'raises an error when balance greater than limit' do
    maximum_balance = OysterCard::MAXIMUM_BALANCE
    subject.top_up(maximum_balance)
	expect{ subject.top_up(1) }.to raise_error "error balance greater than #{maximum_balance}"
end

 describe '#deduct' do
  it 'deducts the minimum' do
  min_charge= OysterCard::MINIMUM_CHARGE
  subject.top_up(10)
  subject.touch_in(station)
  expect{subject.touch_out}.to change{subject.balance}.by -(min_charge)
end
 end
 describe '#touch_in' do
  it 'it touches in' do
  subject.top_up(1)
  subject.touch_in(station)
  expect(subject).to be_in_journey
end
end
 describe '#touch_out' do
 it 'touches out' do
  subject.top_up(1)
  subject.touch_in(station)
  subject.touch_out
  expect(subject).not_to be_in_journey
end
end

 describe '#in_journey?' do
  it 'returns true when in journey' do
    subject.top_up(1)
    subject.touch_in(station)
    expect(subject).to be_in_journey
  end
  it 'returns false initially' do
     subject.top_up(1)
     expect(subject).not_to be_in_journey
end

  it 'returns error:insufficient balance' do
    expect{subject.touch_in(station)}.to raise_error "Insufficient balance"
end
end

describe 'returns entry station' do
  it 'remembers entry station' do
     subject.top_up(10)
     subject.touch_in(station)
     expect(subject.entry_station).to eq station
   end
 end


end
















