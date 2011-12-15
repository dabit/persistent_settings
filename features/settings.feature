Feature: Settings class

  Scenario: Assign a new global setting
    Given I assign "'a value'" to "a_key"
    Then Settings should respond to "a_key"
    Then "a_key" should hold "a value"

  Scenario: Active key list
    Given I assign "'a value'" to "a_key"
    And I assign "'another value'" to "another_key"
    Then Settings.keys should include:
      | a_key       |
      | another_key |

