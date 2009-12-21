require File.join(File.dirname(__FILE__), "..", "..", "spec_helper")

module Craps
  describe DontPassBet do
    before(:each) do
      @game = mock('game').as_null_object
      @game.stub_chain(:point, :current_point => :off)
      @messenger = mock('messenger').as_null_object
      @dont_pass_bet = DontPassBet.new(10, @messenger, @game)
    end

    it "should return :dont_pass" do
      @dont_pass_bet.to_sym.should == :dont_pass
    end

    context "responding to the dice roll when the point is off" do
      it "should increase the funds after winning" do
        @game.should_receive(:funds).and_return(90)
        @game.should_receive(:funds=).with(110)
        @dont_pass_bet.dice_rolled result(1,1)
      end

      it "should win when dice rolled is a 2" do
        @messenger.should_receive(:send_won_bet).with(:dont_pass, 10)
        @dont_pass_bet.dice_rolled result(1,1)
      end

      it "should win when dice rolled is a 3" do
        @messenger.should_receive(:send_won_bet).with(:dont_pass, 10)
        @dont_pass_bet.dice_rolled result(1,2)
      end

      it "should win when dice rolled is a 12" do
        @messenger.should_receive(:send_won_bet).with(:dont_pass, 10)
        @dont_pass_bet.dice_rolled result(6,6)
      end

      it "should be waiting for a 7" do
        @messenger.should_receive(:send_bet_waiting).with(:dont_pass, 10, :seven)
        @dont_pass_bet.dice_rolled result(4,2)
      end

      it "should lose when dice rolled is a 7" do
        @messenger.should_receive(:send_lost_bet).with(:dont_pass, 10)
        @dont_pass_bet.dice_rolled result(4,3)
      end

      it "should lose when dice rolled is a 11" do
        @messenger.should_receive(:send_lost_bet).with(:dont_pass, 10)
        @dont_pass_bet.dice_rolled result(6,5)
      end

      it "should end after winning" do
        @messenger.should_receive(:send_won_bet).once.with(:dont_pass, 10)
        @messenger.should_not_receive(:send_bet_waiting)
        @dont_pass_bet.dice_rolled result(1,1) # bet wins
        @dont_pass_bet.dice_rolled result(1,2) # bet should not win again
        @dont_pass_bet.dice_rolled result(6,6) # bet should not be waiting
      end

      it "should end after losing" do
        @messenger.should_receive(:send_lost_bet).once.with(:dont_pass, 10)
        @messenger.should_not_receive(:send_bet_waiting)
        @dont_pass_bet.dice_rolled result(3,4) # bet loses
        @dont_pass_bet.dice_rolled result(3,4) # bet should not lose again
        @dont_pass_bet.dice_rolled result(5,6) # bet should not be waiting
      end
    end

    context "responding to the dice roll when the point is established as six" do
      before(:each) do
        @game.stub_chain(:point, :current_point => :six)
      end

      it "should lose when dice rolled is a 6" do
        @messenger.should_receive(:send_lost_bet).with(:dont_pass, 10)
        @dont_pass_bet.dice_rolled result(2,4)
      end

      it "should be waiting for a seven" do
        @messenger.should_receive(:send_bet_waiting).with(:dont_pass, 10, :seven)
        @dont_pass_bet.dice_rolled result(2,2)
      end

      it "should win when dice rolled is a 7" do
        @messenger.should_receive(:send_won_bet).with(:dont_pass, 10)
        @dont_pass_bet.dice_rolled result(2,5)
      end

      it "should end after winning" do
        @messenger.should_receive(:send_won_bet).once.with(:dont_pass, 10)
        @messenger.should_not_receive(:send_bet_waiting)
        @dont_pass_bet.dice_rolled result(3,4) # bet wins
        @dont_pass_bet.dice_rolled result(3,4) # bet should not lose
        @dont_pass_bet.dice_rolled result(5,6) # bet should not be waiting
      end

      it "should end after losing" do
        @messenger.should_receive(:send_lost_bet).once.with(:dont_pass, 10)
        @messenger.should_not_receive(:send_bet_waiting)
        @dont_pass_bet.dice_rolled result(3,3) # bet loses
        @dont_pass_bet.dice_rolled result(1,2) # bet should not win
        @dont_pass_bet.dice_rolled result(6,6) # bet should not be waiting
      end
    end
  end
end
