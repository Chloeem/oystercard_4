#!/usr/bin/ruby

class Oystercard
    MAXIMUM_BALANCE = 90
    MINIMUM_BALANCE = 1
    MINIMUM_CHARGE = 1

    attr_reader :balance, :entry_station, :exit_station, :last_journey, :journeys

    def initialize
      @balance = 0
      @last_journey = {}
      @journeys = []
    end

    def top_up(amount)
      fail "Maximum top up limit of #{MAXIMUM_BALANCE} exceeded" unless amount + balance <= MAXIMUM_BALANCE
      @balance += amount
    end

    def touch_in(station)
      fail "Insufficient balance below minimum #{MINIMUM_BALANCE}" unless balance >= MINIMUM_BALANCE
      @last_journey[:entry_station] = station
    end

    def touch_out(exit_station)
      deduct(MINIMUM_CHARGE)
      @last_journey[:exit_station] = exit_station
    end

    private

    def in_journey? 
      !!entry_station 
    end

    def deduct(amount)
      @balance -= amount
    end

end
