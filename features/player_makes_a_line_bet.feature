Feature: player makes a line bet

  As a player
  I want to make a line bet
  So that I can hopefully win

  Background:
    Given I start a new game
    And I have $100

  Scenario Outline: come out roll
    Given I run the command "bet 10 on the <betting area>"
    When I roll a <result> on the roll command
    Then I should see "<message>" after the last roll
    And I should have $<funds>

    Scenarios: pass line bet
      | betting area | result | message                                   | funds |
      | pass line    | 1 + 1  | You lost $10 on the pass line             | 90    |
      | pass line    | 1 + 2  | You lost $10 on the pass line             | 90    |
      | pass line    | 1 + 3  | $10 on the pass line waiting for a four   | 90    |
      | pass line    | 1 + 4  | $10 on the pass line waiting for a five   | 90    |
      | pass line    | 1 + 5  | $10 on the pass line waiting for a six    | 90    |
      | pass line    | 1 + 6  | You won $10 on the pass line              | 110   |
      | pass line    | 6 + 2  | $10 on the pass line waiting for an eight | 90    |
      | pass line    | 6 + 3  | $10 on the pass line waiting for a nine   | 90    |
      | pass line    | 6 + 4  | $10 on the pass line waiting for a ten    | 90    |
      | pass line    | 6 + 5  | You won $10 on the pass line              | 110   |
      | pass line    | 6 + 6  | You lost $10 on the pass line             | 90    |

    Scenarios: don't pass bet
      | betting area | result | message                                  | funds |
      | dont pass    | 1 + 1  | You won $10 on the dont pass             | 110   |
      | dont pass    | 1 + 2  | You won $10 on the dont pass             | 110   |
      | dont pass    | 1 + 3  | $10 on the dont pass waiting for a seven | 90    |
      | dont pass    | 1 + 4  | $10 on the dont pass waiting for a seven | 90    |
      | dont pass    | 1 + 5  | $10 on the dont pass waiting for a seven | 90    |
      | dont pass    | 1 + 6  | You lost $10 on the dont pass            | 90    |
      | dont pass    | 6 + 2  | $10 on the dont pass waiting for a seven | 90    |
      | dont pass    | 6 + 3  | $10 on the dont pass waiting for a seven | 90    |
      | dont pass    | 6 + 4  | $10 on the dont pass waiting for a seven | 90    |
      | dont pass    | 6 + 5  | You lost $10 on the dont pass            | 90    |
      | dont pass    | 6 + 6  | You won $10 on the dont pass             | 110   |

  Scenario Outline: point is eight
    Given I run the command "bet 10 on the <betting area>"
    When I roll a 4 + 4 on the roll command
    And I roll a <result> on the roll command
    Then I should see "<message>" after the last roll
    And I should have $<funds>

    Scenarios: pass line bet
      | betting area | result | message                                   | funds |
      | pass line    | 1 + 1  | $10 on the pass line waiting for an eight | 90    |
      | pass line    | 1 + 2  | $10 on the pass line waiting for an eight | 90    |
      | pass line    | 1 + 3  | $10 on the pass line waiting for an eight | 90    |
      | pass line    | 1 + 4  | $10 on the pass line waiting for an eight | 90    |
      | pass line    | 1 + 5  | $10 on the pass line waiting for an eight | 90    |
      | pass line    | 1 + 6  | You lost $10 on the pass line             | 90    |
      | pass line    | 6 + 2  | You won $10 on the pass line              | 110   |
      | pass line    | 6 + 3  | $10 on the pass line waiting for an eight | 90    |
      | pass line    | 6 + 4  | $10 on the pass line waiting for an eight | 90    |
      | pass line    | 6 + 5  | $10 on the pass line waiting for an eight | 90    |
      | pass line    | 6 + 6  | $10 on the pass line waiting for an eight | 90    |

    Scenarios: don't pass bet
      | betting area | result | message                                  | funds |
      | dont pass    | 1 + 1  | $10 on the dont pass waiting for a seven | 90    |
      | dont pass    | 1 + 2  | $10 on the dont pass waiting for a seven | 90    |
      | dont pass    | 1 + 3  | $10 on the dont pass waiting for a seven | 90    |
      | dont pass    | 1 + 4  | $10 on the dont pass waiting for a seven | 90    |
      | dont pass    | 1 + 5  | $10 on the dont pass waiting for a seven | 90    |
      | dont pass    | 1 + 6  | You won $10 on the dont pass             | 110   |
      | dont pass    | 6 + 2  | You lost $10 on the dont pass            | 90    |
      | dont pass    | 6 + 3  | $10 on the dont pass waiting for a seven | 90    |
      | dont pass    | 6 + 4  | $10 on the dont pass waiting for a seven | 90    |
      | dont pass    | 6 + 5  | $10 on the dont pass waiting for a seven | 90    |
      | dont pass    | 6 + 6  | $10 on the dont pass waiting for a seven | 90    |

  Scenario: bet 10, roll 7, then roll another 7
    Given I run the command "bet 10 on the pass line"
    When I roll a 3 + 4 on the roll command
    And I roll a 3 + 4 on the roll command
    Then I should not see "You won $10 on the pass line" after the last roll

  Scenario: playing pass line after a point is established
    Given The point is currently six
    When I run the command "bet 10 on the pass line"
    Then I should see "You can't bet the pass line right now. Please wait until the point is off"

  Scenario: playing dont pass after a point is established
    Given The point is currently eight
    When I run the command "bet 10 on the dont pass"
    Then I should see "You can't bet the dont pass right now. Please wait until the point is off"

