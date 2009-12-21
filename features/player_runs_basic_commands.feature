Feature: player runs basic commands

  As a player
  I want to run commands
  So that I can interact with the game

  Scenario Outline:
    Given I start a new game
    And I have $100
    When I run the command "<command>"
    Then I should see "<message>"

    Scenarios: basic commands
      | command   | message                        |
      | funds     | You have $100                  |
      | point     | Point is OFF                   |
      | gibberish | I don't understand 'gibberish' |

