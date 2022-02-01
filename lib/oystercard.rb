class Oystercard
    MAXIMUM_LIMIT = 90

    attr_reader :balance

    def initialize
      @balance = 0
      @in_journey = false
    end

    def top_up(amount)
      fail "Maximum top up limit of #{MAXIMUM_LIMIT} exceeded" unless amount + balance <= MAXIMUM_LIMIT
      @balance += amount
    end

    def deduct(amount)
      @balance -= amount
    end

    def in_journey? 
      @in_journey
    end

    def touch_in
      @in_journey = true
    end

end
