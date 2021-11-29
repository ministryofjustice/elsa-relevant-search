Feature: Cookies banner functionality
  Background:
    When I visit "/"
    Then I should see "Cookies on Search information about legal problems"
     And I should see a "View cookies" link to "/cookies"

  Scenario: The banner shows and user accepts it
    When I click the "Accept analytics cookies" button
    Then I should be on "/"
     And I should see "You’ve accepted analytics cookies."
     And I should see a "change your cookie settings" link to "/cookies"
    When I click the "Hide this message" link
    Then I should be on "/"
     And I should not see "You’ve accepted analytics cookies"
     And I should not see "Cookies on Search information about legal problems"

  Scenario: The banner shows and user rejects it
    When I click the "Reject analytics cookies" button
    Then I should be on "/"
     And I should see "You’ve rejected analytics cookies."
     And I should see a "change your cookie settings" link to "/cookies"
    When I click the "Hide this message" link
    Then I should be on "/"
     And I should not see "You’ve rejected analytics cookies"
     And I should not see "Cookies on Search information about legal problems"
