module Craps
  class Point
    attr_accessor :current_point
    
    POINTS = {
      4 => :four,
      5 => :five,
      6 => :six,
      8 => :eight,
      9 => :nine,
      10 => :ten
    }

    def initialize
      @previous_point = :off
      @current_point = :off
    end

    def changed?
      @previous_point != @current_point
    end

    def dice_rolled(result)
      update_point(result[:total])
    end

    protected
    def update_point(roll_total)
      @previous_point = @current_point

      if come_out_roll?
        @current_point = POINTS[roll_total] || :off
      elsif POINTS[roll_total] == @current_point || roll_total == 7
        @current_point = :off
      end
    end

    def come_out_roll?
      @current_point == :off
    end
  end
end
