def dealer
  @dealer ||= Craps::Dealer.new(messenger, game)
end

def dice
  @dice ||= Craps::Dice.new
end

def game
  @game ||= Craps::ConsoleGame.new
end

def messenger
  @messenger ||= Craps::Messenger.new(output)
end

def output
  @output ||= StringIO.new
end

def output_messages
  output.string.split("\n").map { |m| m.gsub(/^>> /, "") }
end

def point
  @point ||= Craps::Point.new
end

def post_roll_messages
  messages = output_messages.dup
  @pre_roll_count.times { messages.delete_at(0) }
  messages
end

Given /^I am not yet playing$/ do
end

Given /^The point is currently (.+)$/ do |new_point|
  point.current_point = new_point.downcase.to_sym
end

Given /^I have \$(\d+)$/ do |amount|
  game.funds = amount.to_i
end

When /^I start a new game$/ do
  game.point = point
  game.dice = dice
  game.messenger = messenger
  game.dealer = dealer
  game.start
end

When /^I run the command "([^\"]*)"$/ do |command|
  game.run_command(command)
end

When /^I roll a (\d{1}) \+ (\d{1}) on the roll command$/ do |die_1, die_2|
  @pre_roll_count = output_messages.size - 1
  dice.stub(:result => {:die_1 => die_1.to_i, :die_2 => die_2.to_i, :total => (die_1.to_i + die_2.to_i)})
  When "I run the command \"roll\""
end

Then /^I should see "([^\"]*)"$/ do |message|
  output_messages.should include(message)
end

Then /^I should see "([^\"]*)" after the last roll$/ do |message|
  post_roll_messages.should include(message)
end

Then /^I should not see "([^\"]*)" after the last roll$/ do |message|
  post_roll_messages.should_not include(message)
end

Then /^I should have \$(\d+)$/ do |amount|
  When "I run the command \"funds\""
  Then "I should see \"You have $#{amount}\""
end

