require 'station'

describe Station do

  subject(:station) { described_class.new }

  it 'has a station class' do
    expect(station).to be_a(Station)
  end

end
