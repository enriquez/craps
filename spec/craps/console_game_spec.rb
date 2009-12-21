require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Craps
  describe ConsoleGame do
    context "starting a new game" do
      before(:each) do
        @dealer = mock('dealer').as_null_object
        @dice = mock('dice').as_null_object
        @messenger = mock('messenger').as_null_object
        @point = mock('point', :changed? => false).as_null_object
        @console_game = ConsoleGame.new

        @console_game.dealer = @dealer
        @console_game.dice = @dice
        @console_game.messenger = @messenger
        @console_game.point = @point
        @console_game.funds = 100
        @console_game.start
      end

      it "should have 100 in funds" do
        @console_game.funds.should == 100
      end

      it "should get the dice" do
        @console_game.dice.should == @dice
      end

      it "should send welcome message" do
        @messenger.should_received(:send_welcome_message)
        @console_game.start
      end

      context "when running commands" do
        it "should send invalid command message" do
          @messenger.should_receive(:send_invalid_command_message).with("gibberish")
          @console_game.run_command("gibberish")
        end

        it "should send funds" do
          @messenger.should_receive(:send_funds).with(100)
          @console_game.run_command("funds")
        end

        context "for viewing the point" do
          it "should get the current point" do
            @point.should_receive(:current_point)
            @console_game.run_command("point")
          end

          it "should send point" do
            @messenger.should_receive(:send_point).with(:off)
            @point.stub(:current_point => :off)
            @console_game.run_command("point")
          end
        end

        context "for rolling the dice" do
          it "should roll the dice" do
            @dice.should_receive(:roll)
            @console_game.run_command("roll")
          end

          it "should roll the dice by running the blank command" do
            @dice.should_receive(:roll)
            @console_game.run_command("")
          end

          it "should send roll result" do
            @messenger.should_receive(:send_roll_result).with({:die_1 => 6, :die_2 => 2, :total => 8})
            @dice.stub(:result => {:die_1 => 6, :die_2 => 2, :total => 8})
            @console_game.run_command("roll")
          end

          it "should send point if it changes" do
            @messenger.should_receive(:send_point).with(:six)
            @point.stub(:current_point => :six, :changed? => true)
            @console_game.run_command("roll")
          end

          it "should not send point if it doesn't change" do
            @messenger.should_not_receive(:send_point).with(:six)
            @point.stub(:current_point => :six, :changed? => false)
            @console_game.run_command("roll")
          end
        end

        context "for betting" do
          it "should make a bet with the dealer" do
            @dealer.should_receive(:take_bet).with(10, :pass_line)
            @console_game.run_command("bet 10 on the pass line")
          end
        end

      end
    end
  end
end
