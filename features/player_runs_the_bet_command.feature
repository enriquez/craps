Feature: player runs the bet command

  As a player
  I want to run the bet command in the form "bet (amount as a number) on the (betting area)"
  So that I can make a bet. duh!

  Scenario Outline:
    Given I start a new game
    And I have $100
    When I run the command "<command>"
    Then I should see "<message>"

    Scenarios:
      | command                  | message                            |
      | bet 10 on the pass line  | $10 bet on the pass line accepted  |
      | bet 200 on the pass line | Can't bet $200. You only have $100 |
      | bet 5 on the pass line   | Can't bet $5. Table minimum is $10 |

