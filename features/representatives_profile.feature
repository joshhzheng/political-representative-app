Feature: Representative Profile

  Scenario: User views a representative's profile
    Given there are representatives in the system
    When I visit the representative's profile page
    Then I should see the representative's name
    And I should see the representative's office title
    And I should see the representative's contact address
    And I should see the representative's political party
    And I should see the representative's photo
    
    