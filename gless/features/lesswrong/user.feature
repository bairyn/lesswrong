Feature: Less Wrong users

  Background: Less Wrong is configured
    Given the user 'admin'
      And the initial site configuration

  Scenario: A user edits their preferences
    Given the user 'Brock_Lee'
      And that the extra user info does not contain 'Lojbanistan'
    When  I set my location to 'Lojbanistan'
    Then  the extra user info contains 'Lojbanistan'

  Scenario: A user can delete themself
    Given the user 'Brock_Lee'
      And logging into 'Brock_Lee' succeeds
    When  I delete my account
    Then  logging into 'Block_Lee' fails
