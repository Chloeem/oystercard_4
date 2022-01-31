require_relative "../lib/oyster_card.rb"

describe Oystercard do
  # for a new instance of oystercard when we give it the balance method it is true
  it 'oystercard responds to balance method' do
    expect(Oystercard.new).to respond_to(:balance)
  end
end