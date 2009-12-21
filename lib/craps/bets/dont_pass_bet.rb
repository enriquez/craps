module Craps
  class DontPassBet < BetBase
    def dice_rolled(result)
      dice_total = result[:total]
      current_point = @game.point.current_point

      if current_point == :off
        case dice_total
        when 4, 5, 6, 8, 9, 10
          bet_waiting(:seven)
        when 2, 3, 12
          bet_won
        when 7, 11
          bet_lost
        end
      elsif dice_total == 7
        bet_won
      elsif current_point == Point::POINTS[dice_total]
        bet_lost
      else
        bet_waiting(:seven)
      end
    end

    def to_sym
      :dont_pass
    end
  end
end
