require_relative "../lib/oyster_card.rb"

describe Oystercard do
  # for a new instance of oystercard when we give it the balance method it is true
  it 'oystercard responds to balance method' do
    expect(Oystercard.new).to respond_to(:balance)
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'changes the amount by 1' do
      expect { subject.top_up(1) }.to change { subject.balance }.by(1)
    end
  end



end