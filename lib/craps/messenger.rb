module Craps
  class Messenger
    def initialize(output)
      @output = output
      @bet_messages = []
    end

    def send_welcome_message
      send_message "Welcome to Craps!"
    end

    def send_bet_accepted(amount, betting_area)
      send_message "$#{amount} bet on the #{underscore_to_space(betting_area)} accepted"
    end

    def send_bet_denied(amount, options = {:reason => ""})
      message = "Can't bet $#{amount}"
      message << ". " << options[:reason] unless options[:reason] == ""
      send_message message
    end

    def send_bet_denied_because_of_table_minimum(amount)
      send_bet_denied(amount, :reason => "Table minimum is $10")
    end

    def send_bet_denied_because_lack_of_funds(amount, funds)
      send_bet_denied(amount, :reason => "You only have $#{funds}")
    end

    def send_bet_area_denied(betting_area, options = {:reason => ""})
      message = "You can't bet the #{underscore_to_space(betting_area)} right now"
      message << ". " << options[:reason] unless options[:reason] == ""
      send_message message
    end

    def send_bet_area_denied_because_there_is_point(betting_area)
      send_bet_area_denied(betting_area, :reason => "Please wait until the point is off")
    end

    def send_funds(funds)
      send_message "You have $#{funds}"
    end

    def send_point(point)
      send_message "Point is #{point.to_s.upcase}"
    end

    def send_roll_result(result)
      send_message "Rolled a #{result[:die_1]} + #{result[:die_2]} = #{result[:total]}"
    end

    def send_invalid_command_message(command)
      send_message "I don't understand '#{command}'"
    end

    def send_bet_waiting(betting_area, amount, point)
      @bet_messages << "$#{amount} on the #{underscore_to_space(betting_area)} waiting for a#{point == :eight ? "n" : ""} #{point}"
    end

    def send_lost_bet(betting_area, amount)
      @bet_messages << "You lost $#{amount} on the #{underscore_to_space(betting_area)}"
    end

    def send_won_bet(betting_area, amount)
      @bet_messages << "You won $#{amount} on the #{underscore_to_space(betting_area)}"
    end

    def send_bet_messages
      @bet_messages.each { |m| send_message m }
      @bet_messages.clear
    end

    def send_command_prompt
      @output.print ">> "
    end

    private
    def send_message message
      @output.puts message
    end

    def underscore_to_space(underscored_word)
      underscored_word.to_s.gsub(/_/, " ")
    end
  end
end
