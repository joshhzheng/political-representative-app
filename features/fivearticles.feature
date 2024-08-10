Feature: Edit news article form

  Scenario: User views the edit news article form with prefilled data
    Given I am on the edit news article page for Representative "1"
    Then I should see the Representative field prefilled with "John Doe"
    And I should see the Issue field prefilled with "Healthcare"
    And I should see a radio button list for articles
    And I should see a select dropdown for Rating
    And I should see a Save button
    And I should see a View news articles button

  Scenario: User submits the form with new data
    Given I am on the edit news article page
    And the Representative field is prefilled with "John Doe"
    And the Issue field is prefilled with "Healthcare"
    And I choose the article "Top 5 Learning Tips" from the list
    And I select "4" from the Rating dropdown
    And I press "Save"
    Then I should be redirected to the news articles page

  Scenario: User views article details
    Given I am on the edit news article page
    And there are articles in the list
    When I click on the article link
    Then I should see the article details in a new tab