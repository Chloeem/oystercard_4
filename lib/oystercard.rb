class Oystercard
    MAXIMUM_BALANCE = 90
    MINIMUM_BALANCE = 1

    attr_reader :balance, :entry_station

    def initialize
      @balance = 0
      @in_journey = false
      @entry_station = []
    end

    def top_up(amount)
      fail "Maximum top up limit of #{MAXIMUM_BALANCE} exceeded" unless amount + balance <= MAXIMUM_BALANCE
      @balance += amount
    end

    def in_journey? 
      true if @entry_station # THIS IS WHERE WE WERE UP TO
    end

    def touch_in(station)
      fail "Insufficient balance below minimum #{MINIMUM_BALANCE}" unless balance >= MINIMUM_BALANCE
      @entry_station << station
      @in_journey = true
    end

    def touch_out
      deduct(MINIMUM_BALANCE)

      if @in_journey == true 
        @in_journey = false && @entry_station = nil
      end
    end

    private

    def deduct(amount)
      @balance -= amount
    end

end
