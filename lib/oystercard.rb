class Oystercard
    MAXIMUM_BALANCE = 90
    MINIMUM_BALANCE = 1

    attr_reader :balance

    def initialize
      @balance = 0
      @in_journey = false
    end

    def top_up(amount)
      fail "Maximum top up limit of #{MAXIMUM_BALANCE} exceeded" unless amount + balance <= MAXIMUM_BALANCE
      @balance += amount
    end

    def in_journey? 
      @in_journey
    end

    def touch_in
      fail "Insufficient balance below minimum #{MINIMUM_BALANCE}" unless balance >= MINIMUM_BALANCE
      @in_journey = true
    end

    def touch_out
      deduct(MINIMUM_BALANCE)
      if @in_journey == true 
        @in_journey = false 
      end
    end

    private

    def deduct(amount)
      @balance -= amount
    end

end
