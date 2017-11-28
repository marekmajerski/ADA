@reg
Feature: Logging into UTOPSA

  @login1
  Scenario: Login to UTOPSA as Fiddle
    Given I open UTOPSA page
    When I login to UTOPSA as "fiddle"
    Then I logged to UTOPSA
    When I logout from UTOPSA
