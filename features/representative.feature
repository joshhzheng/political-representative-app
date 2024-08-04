Feature: Map Interaction

  Scenario: Clicking on a state displays counties
    Given I am on the map page
    When I click on "California"
    Then I should see a list of counties in California

  Scenario: Clicking on a county displays representatives
    Given I am viewing counties in California
    When I click on "Los Angeles County"
    Then I should see representatives for Los Angeles County