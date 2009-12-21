Feature: player rolls the dice

  As a player
  I want to roll the dice and see the result
  So that I can play the game

  Scenario Outline:
    Given I start a new game
    When I roll a <result> on the roll command
    Then I should see "<message>" after the last roll

    Scenarios: roll messages
      | result | message             |
      | 1 + 1  | Rolled a 1 + 1 = 2  |
      | 1 + 2  | Rolled a 1 + 2 = 3  |
      | 1 + 3  | Rolled a 1 + 3 = 4  |
      | 1 + 4  | Rolled a 1 + 4 = 5  |
      | 1 + 5  | Rolled a 1 + 5 = 6  |
      | 1 + 6  | Rolled a 1 + 6 = 7  |
      | 6 + 2  | Rolled a 6 + 2 = 8  |
      | 6 + 3  | Rolled a 6 + 3 = 9  |
      | 6 + 4  | Rolled a 6 + 4 = 10 |
      | 6 + 5  | Rolled a 6 + 5 = 11 |
      | 6 + 6  | Rolled a 6 + 6 = 12 |

