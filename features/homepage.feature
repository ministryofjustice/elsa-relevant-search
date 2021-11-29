Feature: Homepage basic checks
  Background:
    When I visit "/"
     And I accept analytics cookies

  Scenario: Check main elements of the page
    Then I should see "Search information about legal problems"
     And I should see "Common search terms"

  Scenario: Check common search terms categories
    Then I should see a "Benefits" category
     And I should see a "Debt" category
     And I should see a "Employment" category
     And I should see a "Housing and homelessness" category
