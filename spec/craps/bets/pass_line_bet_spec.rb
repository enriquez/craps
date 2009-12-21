require File.join(File.dirname(__FILE__), "..", "..", "spec_helper")

module Craps
  describe PassLineBet do
    before(:each) do
      @game = mock('game').as_null_object
      @game.stub_chain(:point, :current_point => :off)
      @messenger = mock('messenger').as_null_object
      @pass_line_bet = PassLineBet.new(10, @messenger, @game)
    end

    it "should return :pass_line" do
      @pass_line_bet.to_sym.should == :pass_line
    end

    context "responding to the dice roll when the point is off" do
      it "should increase the funds after winning" do
        @game.should_receive(:funds).and_return(90)
        @game.should_receive(:funds=).with(110)
        @pass_line_bet.dice_rolled result(3,4)
      end

      it "should lose when dice rolled is a 2" do
        @messenger.should_receive(:send_lost_bet).with(:pass_line, 10)
        @pass_line_bet.dice_rolled result(1,1)
      end

      it "should lose when dice rolled is a 3" do
        @messenger.should_receive(:send_lost_bet).with(:pass_line, 10)
        @pass_line_bet.dice_rolled result(1,2)
      end

      it "should lose when dice rolled is a 12" do
        @messenger.should_receive(:send_lost_bet).with(:pass_line, 10)
        @pass_line_bet.dice_rolled result(6,6)
      end

      it "should be waiting for the point" do
        @messenger.should_receive(:send_bet_waiting).with(:pass_line, 10, :six)
        @pass_line_bet.dice_rolled result(4,2)
      end

      it "should win when dice rolled is a 7" do
        @messenger.should_receive(:send_won_bet).with(:pass_line, 10)
        @pass_line_bet.dice_rolled result(3,4)
      end

      it "should win when dice rolled is a 11" do
        @messenger.should_receive(:send_won_bet).with(:pass_line, 10)
        @pass_line_bet.dice_rolled result(5,6)
      end

      it "should end after winning" do
        @messenger.should_receive(:send_won_bet).once.with(:pass_line, 10)
        @messenger.should_not_receive(:send_bet_waiting)
        @pass_line_bet.dice_rolled result(4,3) # bet wins
        @pass_line_bet.dice_rolled result(4,3) # should not win again
        @pass_line_bet.dice_rolled result(3,1) # should not be waiting
      end

      it "should end after losing" do
        @messenger.should_receive(:send_lost_bet).once.with(:pass_line, 10)
        @messenger.should_not_receive(:send_bet_waiting)
        @pass_line_bet.dice_rolled result(1,1) # bet loses
        @pass_line_bet.dice_rolled result(6,6) # should not lose again
        @pass_line_bet.dice_rolled result(3,1) # should not be waiting
      end
    end

    context "responding to the dice roll when the point is established as six" do
      before(:each) do
        @game.stub_chain(:point, :current_point => :six)
      end

      it "should lose when dice rolled is a 7" do
        @messenger.should_receive(:send_lost_bet).with(:pass_line, 10)
        @pass_line_bet.dice_rolled result(2,5)
      end

      it "should be waiting for a 6" do
        @messenger.should_receive(:send_bet_waiting).with(:pass_line, 10, :six)
        @pass_line_bet.dice_rolled result(1,1)
      end

      it "should win when dice rolled is a 6" do
        @messenger.should_receive(:send_won_bet).with(:pass_line, 10)
        @pass_line_bet.dice_rolled result(5,1)
      end

      it "should end after winning" do
        @messenger.should_receive(:send_won_bet).once.with(:pass_line, 10)
        @messenger.should_not_receive(:send_bet_waiting)
        @pass_line_bet.dice_rolled result(3,3) # bet wins
        @pass_line_bet.dice_rolled result(3,3) # bet should not win
        @pass_line_bet.dice_rolled result(1,3) # bet should not be waiting
      end

      it "should end after losing" do
        @messenger.should_receive(:send_lost_bet).once.with(:pass_line, 10)
        @messenger.should_not_receive(:send_bet_waiting)
        @pass_line_bet.dice_rolled result(2,5) # bet loses
        @pass_line_bet.dice_rolled result(5,2) # bet should not lose
        @pass_line_bet.dice_rolled result(1,3) # bet should not be waiting
      end
    end
    
  end
end
