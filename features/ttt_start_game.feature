Feature: player starts game

  As the player
  I want to start the game
  So I can play Tic Tac Toe with a friend

  Scenario: start game
    Given I am not yet playing
    When I start a new game
    Then I should see "What Language would you like?"
    And I should see the option for English or Spanish with a prompt
