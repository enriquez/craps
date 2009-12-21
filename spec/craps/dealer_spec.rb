require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Craps
  describe Dealer do
    before(:each) do
      @messenger = mock('messenger').as_null_object
      @game = mock('game', :funds => 100).as_null_object
      @dealer = Dealer.new(@messenger, @game)
    end
    it "should create a bet" do
      PassLineBet.should_receive(:new).and_return(mock('pass line bet', :valid? => true))
      @dealer.take_bet(10, :pass_line)
    end
    it "should send bet accepted for a valid bet" do
      PassLineBet.stub(:new => mock('pass line bet', :valid? => true))
      @messenger.should_receive(:send_bet_accepted).with(10, :pass_line)
      @dealer.take_bet(10, :pass_line)
    end
    it "should send bet denied due to lack of funds" do
      @messenger.should_receive(:send_bet_denied_because_lack_of_funds).with(200, 100)
      @dealer.take_bet(200, :pass_line)
    end
    it "should send bet denied due to $10 minimum" do
      @messenger.should_receive(:send_bet_denied_because_of_table_minimum).with(5)
      @dealer.take_bet(5, :pass_line)
    end
  end
end
