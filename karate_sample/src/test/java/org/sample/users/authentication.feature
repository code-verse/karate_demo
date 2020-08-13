Feature: user authentication test script
  for help, see: https://github.com/intuit/karate/wiki/IDE-Support

  Background:
    * url 'http://localhost:5000'

  Scenario: failed to get authentication token
    Given path 'auth'
    And request { username: 'user', password: 'user_password' }
    When method post
    Then status 200
    And match response.status == 'FAILED'

  Scenario: successfully get authentication token
    * json authentication_request = read('classpath:org/sample/templates/users/credential.json')

    Given path 'auth'
    And request authentication_request
    When method post
    Then status 200
    And match response.status == 'SUCCESS'
    And def token = response.token