require_relative '../lib/oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }

  it 'oystercard responds to balance method' do
    expect(oystercard).to respond_to(:balance)
  end

  it 'starts with an empty list of journeys' do
    expect(oystercard.journeys).to be_empty
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'changes the amount by 1' do
      expect { oystercard.top_up(1) }.to change { oystercard.balance }.by(1)
    end

    it 'Raises an error when top up exceeds the limit of £90' do
      max_balance = Oystercard::MAXIMUM_BALANCE
      oystercard.top_up(max_balance)
      expect { oystercard.top_up(max_balance) }.to raise_error("Maximum top up limit of #{maxi_balance} exceeded")
    end
  end

  describe '#touch_in' do
    let(:entry_station) { double :station }

    it { is_expected.to respond_to(:touch_in) }

    it 'raises an error when balance is less minimum balance' do
      expect { oystercard.touch_in(entry_station) }.to raise_error("Insufficient balance below minimum #{Oystercard::MINIMUM_BALANCE}")
    end

    it 'stores an entry station on touch in' do
      oystercard.top_up(Oystercard::MINIMUM_CHARGE)
      oystercard.touch_in(entry_station)
      expect(oystercard.current_journey[:entry_station]).to eq(entry_station)
    end
  end

  describe '#touch_out' do
    let(:entry_station) { double :station }
    let(:exit_station) { double :station }
    it { is_expected.to respond_to(:touch_out) }

    it 'touches out the user at the end of the journey' do
      oystercard.top_up(Oystercard::MINIMUM_BALANCE)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      # expect(oystercard.current_journey).to eq( { entry_station: nil, exit_station: nil } )
    end

    it 'should deduct at the end of the journey with the minimum fare' do
      oystercard.top_up(Oystercard::MINIMUM_CHARGE)
      oystercard.touch_in(entry_station)
      expect { oystercard.touch_out(exit_station) }.to change { oystercard.balance }.by(-Oystercard::MINIMUM_CHARGE)
    end

    it 'stores an exit station on touch out' do
      oystercard.top_up(Oystercard::MAXIMUM_BALANCE)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.current_journey[:exit_station]).to eq(exit_station)
    end
  end

  describe '#journeys' do
    let(:entry_station) { double :station }
    let(:exit_station) { double :station }
    let(:journey) { { entry_station: entry_station, exit_station: exit_station } }

    it 'starts with an empty list of journeys' do
      expect(oystercard.journeys).to be_empty
    end

    it 'saves one journey after touching in and out' do
      oystercard.top_up(Oystercard::MAXIMUM_BALANCE)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.journeys).to include(journey)
    end
  end
end
