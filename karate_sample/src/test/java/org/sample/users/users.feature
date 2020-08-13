Feature: sample user modules test script
  for help, see: https://github.com/intuit/karate/wiki/IDE-Support

  Background:
    * url 'http://localhost:5000'
    * def authentication_result = call read('classpath:org/sample/users/authentication.feature')
    * header x-token = authentication_result.token

  Scenario: get user by id with invalid auth token
    * def user_id = 2

    Given path 'user', user_id
    And header x-token = 'RANDOM_STRING_HERE'
    When method get
    Then status 401

  Scenario: get user by id
    * def user_id = 1

    Given path 'user', user_id
    When method get
    Then status 200
    And match response.user_id == user_id
    And def user_data = response