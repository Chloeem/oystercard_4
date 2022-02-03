#!/usr/bin/env ruby

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1

  attr_reader :balance, :current_journey, :journeys

  def initialize
    @balance = 0
    @current_journey = { entry_station: nil, exit_station: nil }
    @journeys = []
  end

  def top_up(amount)
    raise "Maximum top up limit of #{MAXIMUM_BALANCE} exceeded" unless amount + balance <= MAXIMUM_BALANCE

    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient balance below minimum #{MINIMUM_BALANCE}" unless balance >= MINIMUM_BALANCE

    @current_journey[:entry_station] = station
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    @current_journey[:exit_station] = station
    @journeys << @current_journey
    # Think about moving some of this out into a new private method
  end

  private

  def in_journey?
    !!entry_station
  end

  def deduct(amount)
    @balance -= amount
  end
end
