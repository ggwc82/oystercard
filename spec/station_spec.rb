require 'station'

 describe Station do

	subject(:station) {described_class.new}

  it 'creates a new station' do
  	expect(described_class.new).to be_a(Station)

  end
end