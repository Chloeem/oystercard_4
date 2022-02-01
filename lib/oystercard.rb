class Oystercard
    attr_reader :balance
    MAXIMUM_LIMIT = 90

    def initialize
      @balance = 0
    end

    def top_up(amount)
      fail "Maximum top up limit of #{MAXIMUM_LIMIT} exceeded" unless amount + balance <= MAXIMUM_LIMIT
      @balance += amount
    end

end
