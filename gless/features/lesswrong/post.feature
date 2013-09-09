Feature: Less Wrong posting

  Background: Less Wrong is configured
    Given the user 'admin'
      And the initial site configuration

  Scenario: A user posts an article on Main
    Given the user 'Candace_Spencer'
    When  I post 'To seek it with thimbles, to seek it with care' to 'Less Wrong' with content 'To pursue it with forks and hope'
    Then  the article should contain 'sue'
      And I should be in the category 'Less Wrong'

  Scenario: A user posts an article on Discussion
    Given the user 'Candace_Spencer'
    When  I post 'To threaten its life with a railway-share' to 'Less Wrong Discussion' with content 'To charm it with smiles and soap!'
    Then  the article should contain 'smiles'
      And I should be in the category 'Less Wrong Discussion'

  Scenario: A guest views the posts created by the prior scenarios
    Given the post 'To seek it with thimbles, to seek it with care'
      And I am logged out
      And the categories are available
    When  I open the post 'To seek it with thimbles, to seek it with care'
    Then  the article should contain 'hope'

  Scenario: A user up-votes an article
    Given the user 'Summer_Holiday'
      And I'm on the post 'To threaten its life with a railway-share'
    When  I up-vote the article
    Then  the article should have '1' vote if unhidden

  Scenario: A user comments
    Given the user 'foo'
      And I'm on the post 'To seek it with thimbles, to seek it with care'
    When  I comment 'bar'
    Then  a comment should contain 'bar'

  Scenario: A user creates a meetup
    Given the user 'Summer_Beach'
    When  I add meetup 'foo' at 'Nantucket' with description 'bar'
    Then  I am on a meetup page
