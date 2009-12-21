require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Craps
  describe Point do
    before(:each) do
      @point = Point.new
    end

    it "should initialize the current point to off" do
      @point.current_point.should == :off
    end

    it "should initialze the point to not be changed" do
      @point.should_not be_changed
    end

    it "should set the current point" do
      @point.current_point = :six
      @point.current_point.should == :six
    end

    context "updating on dice_rolled" do
      context "point starts off" do
        it "should become five" do
          @point.dice_rolled result(3,2)
          @point.current_point.should == :five
        end

        it "should stay off" do
          @point.dice_rolled result(6,6)
          @point.current_point.should == :off
        end

        it "should be changed" do
          @point.dice_rolled result(4,4)
          @point.should be_changed
        end
      end

      context "point starts as eight" do
        before(:each) do
          @point.current_point = :eight
        end

        it "should become off when roll is eight" do
          @point.dice_rolled result(4,4)
          @point.current_point.should == :off
        end

        it "should stay eight when roll is two" do
          @point.dice_rolled result(1,1)
          @point.current_point.should == :eight
        end
      end
    end
  end
end
