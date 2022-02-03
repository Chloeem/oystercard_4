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
    log_journey(current_journey)
  end

  private

  def log_journey(current_journey)
    @journeys << current_journey
  end

  def in_journey?
    !!current_journey[:entry_station] && current_journey[:exit_station] == nil
  end

  def deduct(amount)
    @balance -= amount
  end
end
