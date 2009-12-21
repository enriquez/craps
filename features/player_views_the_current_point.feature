Feature: player views the current point

  As a player
  I want to see what the current point is on the "point" command and when
    the point changes
  So that I can bet accordingly

  Background:
    Given I start a new game

  Scenario Outline:
    Given The point is currently <starting point>
    And I roll a <result> on the roll command
    When I run the command "point"
    Then I should see "<message>"

    Scenarios: come out roll
      | starting point | result | message        |
      | off            | 1 + 1  | Point is OFF   |
      | off            | 1 + 2  | Point is OFF   |
      | off            | 1 + 3  | Point is FOUR  |
      | off            | 1 + 4  | Point is FIVE  |
      | off            | 1 + 5  | Point is SIX   |
      | off            | 1 + 6  | Point is OFF   |
      | off            | 6 + 2  | Point is EIGHT |
      | off            | 6 + 3  | Point is NINE  |
      | off            | 6 + 4  | Point is TEN   |
      | off            | 6 + 5  | Point is OFF   |
      | off            | 6 + 6  | Point is OFF   |

    Scenarios: point is six
      | starting point | result | message        |
      | six            | 1 + 1  | Point is SIX   |
      | six            | 1 + 2  | Point is SIX   |
      | six            | 1 + 3  | Point is SIX   |
      | six            | 1 + 4  | Point is SIX   |
      | six            | 1 + 5  | Point is OFF   |
      | six            | 1 + 6  | Point is OFF   |
      | six            | 6 + 2  | Point is SIX   |
      | six            | 6 + 3  | Point is SIX   |
      | six            | 6 + 4  | Point is SIX   |
      | six            | 6 + 5  | Point is SIX   |
      | six            | 6 + 6  | Point is SIX   |

    Scenarios: point is eight
      | starting point | result | message        |
      | eight          | 1 + 1  | Point is EIGHT |
      | eight          | 1 + 2  | Point is EIGHT |
      | eight          | 1 + 3  | Point is EIGHT |
      | eight          | 1 + 4  | Point is EIGHT |
      | eight          | 1 + 5  | Point is EIGHT |
      | eight          | 1 + 6  | Point is OFF   |
      | eight          | 6 + 2  | Point is OFF   |
      | eight          | 6 + 3  | Point is EIGHT |
      | eight          | 6 + 4  | Point is EIGHT |
      | eight          | 6 + 5  | Point is EIGHT |
      | eight          | 6 + 6  | Point is EIGHT |

  Scenario Outline:
    When I roll a <result> on the roll command
    Then I should see "<message>" after the last roll

    Scenarios: showing the point when it changes
      | result | message        |
      | 1 + 1  |                |
      | 1 + 2  |                |
      | 1 + 3  | Point is FOUR  |
      | 1 + 4  | Point is FIVE  |
      | 1 + 5  | Point is SIX   |
      | 1 + 6  |                |
      | 6 + 2  | Point is EIGHT |
      | 6 + 3  | Point is NINE  |
      | 6 + 4  | Point is TEN   |
      | 6 + 5  |                |
      | 6 + 6  |                |

