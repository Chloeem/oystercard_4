require_relative "../lib/oystercard.rb"

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

    it 'Raises an error when top up exceeds the limit of £90' do
      maximum_limit = Oystercard::MAXIMUM_LIMIT 
      subject.top_up(maximum_limit)             
      expect { subject.top_up(1) }.to raise_error("Maximum top up limit of #{maximum_limit} exceeded")
    end
  end

  describe "#deduct" do
      it { is_expected.to respond_to(:deduct).with(1).argument }

      it 'deducts an amount from the balance' do
        subject.top_up(10)
        expect { subject.deduct(1) }.to change {subject.balance }.by(-1)
      end
  end

  describe '#in_journey?' do
    it 'starts off not in a journey' do
      expect(subject).not_to be_in_journey 
    end
    
  end

  # describe '#touch_in' do
  #   it { is_expected.to respond_to(:touch_in) }

  #   it 'touches in user at beginning of journey' do
  #     expect {}
  #   end
  # end

end
