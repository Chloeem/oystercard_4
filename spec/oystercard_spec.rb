require_relative "../lib/oystercard.rb"

describe Oystercard do
  it 'oystercard responds to balance method' do
    expect(Oystercard.new).to respond_to(:balance)
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'changes the amount by 1' do
      expect { subject.top_up(1) }.to change { subject.balance }.by(1)
    end

    it 'Raises an error when top up exceeds the limit of £90' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)             
      expect { subject.top_up(maximum_balance) }.to raise_error("Maximum top up limit of #{maximum_balance} exceeded")
    end
  end

  # describe '#in_journey?' do
  #   it 'starts off not in a journey' do
  #     expect(subject).not_to be_in_journey 
  #   end
  # end

  describe '#touch_in' do
    let(:station){ double :station }

    it { is_expected.to respond_to(:touch_in) }

    it 'touches in user at beginning of journey' do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      subject.touch_in(station)
      expect(subject.entry_station[0]).to eq(station)
    end

    it 'raises an error when balance is less minimum balance' do
      expect { subject.touch_in(station)}.to raise_error("Insufficient balance below minimum #{Oystercard::MINIMUM_BALANCE}")
    end

    it 'remembers the entry station on touch in' do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      expect { subject.touch_in(station) }.to change { subject.entry_station[0] }.to(station)
    end

  end

  describe '#touch_out' do
    let(:station){ double :station }

    it { is_expected.to respond_to(:touch_out) }

    it 'touches out the user at the end of the journey' do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      subject.touch_in(station)
      subject.touch_out
      expect(subject.entry_station).to eq(nil)
    end

    it 'should deduct at the end of the journey with the minimum fare' do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      subject.touch_in(station)
      expect { subject.touch_out }.to change { subject.balance }.by(-Oystercard::MINIMUM_BALANCE)
    end
  end

end
