#!/usr/bin/ruby

class Oystercard
    MAXIMUM_BALANCE = 90
    MINIMUM_BALANCE = 1
    MINIMUM_CHARGE = 1

    attr_reader :balance, :entry_station, :exit_station

    def initialize
      @balance = 0
      @journeys = { entry_station: nil, exit_station: nil }
      @exit_station = nil
    end

    def top_up(amount)
      fail "Maximum top up limit of #{MAXIMUM_BALANCE} exceeded" unless amount + balance <= MAXIMUM_BALANCE
      @balance += amount
    end

    def touch_in(station)
      fail "Insufficient balance below minimum #{MINIMUM_BALANCE}" unless balance >= MINIMUM_BALANCE
      @entry_station = station
    end

    def touch_out(exit_station)
      deduct(MINIMUM_CHARGE)
      @entry_station = nil
      @exit_station = exit_station
    end

    private

    def in_journey? 
      !!entry_station 
    end

    def deduct(amount)
      @balance -= amount
    end

end
