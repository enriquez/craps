require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Craps
  describe Dice do
    before(:each) do
      @dice = Dice.new
    end

    it "should not have any values before rolling" do
      @dice.values.should be_nil
    end

    it "should not have a total before rolling" do
      @dice.total.should be_nil
    end

    it "should roll two random numbers from 1 to 6" do
      # run a bunch of times to get a good sample
      100.times do
        @dice.roll

        @dice.values[0].should >= 1
        @dice.values[0].should <= 6

        @dice.values[1].should >= 1
        @dice.values[1].should <= 6
      end
    end

    it "should get the total" do
      @dice.roll
      @dice.total.should == @dice.values.sum
    end

    it "should get the result hash" do
      @dice.roll
      @dice.result.should == {:die_1 => @dice.values[0], :die_2 => @dice.values[1], :total => @dice.values.sum}
    end

    it "should notify observers on roll with the values" do
      observer = mock('observer')
      @dice.observers << observer

      observer.should_receive(:dice_rolled)
      @dice.roll
    end

  end
end
