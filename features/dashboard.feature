Feature: Dashboard
  As a user 
  I want to have a dashboard view of my time
  So that I can quickly enter my activities
  
  Scenario: I have no current activity
    Given I am a user
    When I view the dashboard
    Then I should not see a last activity

  Scenario: I have a current activity
    Given I am a user
    When I view the dashboard
    Then I should not see my last activity

  Scenario: I have not entered my time in several intervals
    Given I am a user
    When I view the dashboard
    Then I should see multiple time interval blocks