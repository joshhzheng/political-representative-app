Feature: Representative Profile

Background: representative profile in database
	Given there are representatives in the system
	When I visit the representative's profile page

Scenario: User views a representative's name and office
	Then I should see the representative's name
	And I should see the representative's office title

Scenario: User views a representative's address, party, photo
	Then I should see the representative's contact address
	And I should see the representative's political party
	And I should see the representative's photo   