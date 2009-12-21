module Craps
  class BetBase
    def initialize(amount, messenger, game)
      @amount = amount
      @game = game
      @messenger = messenger
      @active = valid?

      if valid?
        @game.funds -= @amount
      else
        @messenger.send_bet_area_denied_because_there_is_point(to_sym)
      end
    end

    def valid?
      @game.point.current_point == :off
    end

    def to_sym
      :bet_base
    end

    protected
    def bet_won
      if @active
        @game.funds += @amount * 2
        @messenger.send_won_bet(to_sym, @amount)
      end
      @active = false
    end

    def bet_lost
      @messenger.send_lost_bet(to_sym, @amount) if @active
      @active = false
    end

    def bet_waiting(point)
      @messenger.send_bet_waiting(to_sym, @amount, point) if @active
    end

  end
end
