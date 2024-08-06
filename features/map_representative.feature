Feature: Click on a county to see its representatives
  As a user
  So that I can find my representatives
  I want to click on the county to see its representatives 

  Scenario: See representatives in Santa Clara
    Given I am on the home page
    When I click on state "CA"
    And I click on county "Santa Clara County"
    Then I should see text matching "Lawrence E. Stone"

  Scenario: See representatives in Dallam County
    Given I am on the home page
    When I click on state "TX"
    And I click on county "Dallam County"
    Then I should see text matching "Shane Stevenson"
    