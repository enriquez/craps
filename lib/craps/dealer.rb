module Craps
  class Dealer
    def initialize(messenger, game)
      @messenger = messenger
      @game = game
    end

    def take_bet(amount, betting_area)
      if @game.funds < amount
        @messenger.send_bet_denied_because_lack_of_funds(amount, @game.funds)
      elsif 10 > amount
        @messenger.send_bet_denied_because_of_table_minimum(amount)
      else
        create_bet(betting_area, amount)
      end
    end

    protected
    def create_bet(betting_area, amount)
      klass_name = "Craps::" << "#{betting_area}_bet".classify
      klass = klass_name.constantize
      bet = klass.new(amount, @messenger, @game)
      if bet.valid?
        @game.dice.observers << bet
        @messenger.send_bet_accepted(amount, betting_area)
      end
    end
  end
end
