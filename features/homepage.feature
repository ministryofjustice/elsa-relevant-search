Feature: Homepage basic checks
  Scenario: Check main elements of the page
    When I visit "/"
    Then I should see "Search information about legal problems"
     And I should see "Common search terms"
