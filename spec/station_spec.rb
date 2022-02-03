require './lib/station.rb'

describe Station do
  subject { described_class.new(name = "Hackney Wick", zone = 2) }

  it 'knows its name' do
    expect(subject.name).to eq("Hackney Wick")
  end

  it 'knows its zone' do
    expect(subject.zone).to eq(2)
  end
end