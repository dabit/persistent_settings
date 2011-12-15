Feature: Settings class

  Scenario: Assign a new global setting
    Given I assign "'a value'" to "a_key"
    Then Settings should respond to "a_key"
    Then "a_key" should hold "a value"
