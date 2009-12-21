module Craps
  class PassLineBet < BetBase
    def dice_rolled(result)
      dice_total = result[:total]
      current_point = @game.point.current_point

      if current_point == :off
        case dice_total
        when 4, 5, 6, 8, 9, 10
          bet_waiting(Point::POINTS[dice_total])
        when 2, 3, 12
          bet_lost
        when 7, 11
          bet_won
        end
      elsif dice_total == 7
        bet_lost
      elsif current_point == Point::POINTS[dice_total]
        bet_won
      else
        bet_waiting(current_point)
      end
    end

    def to_sym
      :pass_line
    end
  end
end

