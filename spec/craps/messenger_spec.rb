require File.join(File.dirname(__FILE__), "..", "spec_helper")

module Craps
  describe Messenger do
    def output_should_receive_message(message)
      @output.should_receive(:puts).with(message)
    end

    before(:each) do
      @output = mock('output').as_null_object
      @messenger = Messenger.new(@output)
    end

    it "should output Welcome to Craps!" do
      output_should_receive_message("Welcome to Craps!")
      @messenger.send_welcome_message
    end

    it "should output $10 bet on the pass line accepted" do
      output_should_receive_message("$10 bet on the pass line accepted")
      @messenger.send_bet_accepted(10, :pass_line)
    end

    it "should output Can't bet $20" do
      output_should_receive_message("Can't bet $20")
      @messenger.send_bet_denied(20)
    end

    it "should output Can't bet $5. Table minimum is $10" do
      output_should_receive_message("Can't bet $5. Table minimum is $10")
      @messenger.send_bet_denied_because_of_table_minimum(5)
    end

    it "should output Can't bet $200. You only have $10" do
      output_should_receive_message("Can't bet $200. You only have $10")
      @messenger.send_bet_denied_because_lack_of_funds(200, 10)
    end

    it "should output You can't bet the pass line right now" do
      output_should_receive_message("You can't bet the pass line right now")
      @messenger.send_bet_area_denied(:pass_line)
    end

    it "should output You can't bet the pass line right now. Please wait until the point is off" do
      output_should_receive_message("You can't bet the pass line right now. Please wait until the point is off")
      @messenger.send_bet_area_denied_because_there_is_point(:pass_line)
    end

    it "should output You have $15" do
      output_should_receive_message("You have $15")
      @messenger.send_funds(15)
    end

    it "should output Point is SIX" do
      output_should_receive_message("Point is SIX")
      @messenger.send_point(:six)
    end

    it "should output Rolled a 2 + 3 = 5" do
      output_should_receive_message("Rolled a 2 + 3 = 5")
      @messenger.send_roll_result({:die_1 => 2, :die_2 => 3, :total => 5})
    end

    it "should output I don't understand 'gibberish'" do
      output_should_receive_message("I don't understand 'gibberish'")
      @messenger.send_invalid_command_message("gibberish")
    end

    it "should output $10 on the pass line waiting for an eight" do
      output_should_receive_message("$10 on the pass line waiting for an eight")
      @messenger.send_bet_waiting(:pass_line, 10, :eight)
      @messenger.send_bet_messages
    end

    it "should output You lost $40 on the dont pass" do
      output_should_receive_message("You lost $40 on the dont pass")
      @messenger.send_lost_bet(:dont_pass, 40)
      @messenger.send_bet_messages
    end

    it "should output You won $100 on the pass line" do
      output_should_receive_message("You won $100 on the pass line")
      @messenger.send_won_bet(:pass_line, 100)
      @messenger.send_bet_messages
    end

    it "should print >>" do
      @output.should_receive(:print).with(">> ")
      @messenger.send_command_prompt
    end
  end
end
