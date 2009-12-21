module Craps
  class ConsoleGame
    attr_writer :messenger, :dealer
    attr_accessor :point, :funds, :dice

    def initialize
      @bet_messages = []
    end

    def start
      @dice.observers << @point
      @messenger.send_welcome_message
      @messenger.send_command_prompt
    end

    def run_command(command)
      case command
      when /bet (\d+) on the (.+)/
        amount = $1.to_i
        betting_area = $2.gsub(" ", "_").to_sym
        @dealer.take_bet(amount, betting_area)
      when /funds/
        @messenger.send_funds(@funds)
      when /point/
        @messenger.send_point(@point.current_point)
      when /roll/, ""
        roll_dice
      else
        @messenger.send_invalid_command_message(command)
      end

      @messenger.send_command_prompt
    end

    def roll_dice
      @dice.roll
      @messenger.send_roll_result(@dice.result)
      @messenger.send_point(@point.current_point) if @point.changed?
      @messenger.send_bet_messages
    end
  end
end
