module Craps
  class Dice
    attr_reader :values, :total
    attr_accessor :observers
    def initialize
      @observers = []
    end
    def roll
      @values = [rand(6) + 1, rand(6) + 1]
      @total = @values.sum
      @observers.reverse.each do |observer|
        observer.dice_rolled(result)
      end
    end
    def result
      {
        :die_1 => @values[0],
        :die_2 => @values[1],
        :total => @values.sum
      }
    end
  end
end
