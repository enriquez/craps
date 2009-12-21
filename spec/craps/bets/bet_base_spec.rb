require File.join(File.dirname(__FILE__), "..", "..", "spec_helper")

module Craps
  describe BetBase, " initializing" do
    before(:each) do
      @messenger = mock('messenger').as_null_object
      @game = mock('game').as_null_object
    end

    context "when the point is off" do
      before(:each) do
        @game.stub_chain(:point, :current_point => :off)
      end

      it "should decrease the funds" do
        @game.should_receive(:funds).and_return(100)
        @game.should_receive(:funds=).with(90)
        bet = BetBase.new(10, @messenger, @game)
      end

      it "should be valid" do
        bet = BetBase.new(10, @messenger, @game)
        bet.should be_valid
      end
    end

    context "when the point is established" do
      before(:each) do
        @game.stub_chain(:point, :current_point => :six)
      end

      it "should not decrease the funds" do
        @game.should_not_receive(:funds).and_return(100)
        @game.should_not_receive(:funds=).with(90)
        bet = BetBase.new(10, @messenger, @game)
      end

      it "should not be valid" do
        bet = BetBase.new(10, @messenger, @game)
        bet.should_not be_valid
      end

      it "should send bet area denied" do
        @messenger.should_receive(:send_bet_area_denied_because_there_is_point)
        bet = BetBase.new(10, @messenger, @game)
      end
    end

  end
end
