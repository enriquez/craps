Feature: player starts game

  As a player
  I want to start a game
  So that I can have fun

  Scenario: start game
    Given I am not yet playing
    When I start a new game
    Then I should see "Welcome to Craps!"

