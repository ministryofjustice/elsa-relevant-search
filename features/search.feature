Feature: Search functionality
  Background:
    When I visit "/"
     And I accept analytics cookies

  Scenario: Searching for something, happy path
    Then I fill in "Enter your search terms" with "how to claim child benefit"
     And I click the search button
    Then I should get "10" results
     And I should see a search result with title "Claim Child Benefit: How to claim - GOV.UK"
     And I take a screenshot with name "search_results" to detect changes

  Scenario: Using a quick search link
    Then I click the "unfair dismissal" link
    Then I should get "10" results
     And I should see a search result with title "Dismissing staff: Unfair dismissals - GOV.UK"

  Scenario: Searching for something that does not return any results
    Then I fill in "Enter your search terms" with "kakorrhaphiophobia"
    And I click the search button
    Then I should get "0" results
    And I should see "No results found. Please try again using different search terms."
    And I take a screenshot with name "search_no_results" to detect changes
