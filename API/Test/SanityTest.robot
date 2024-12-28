#
#
#*** Settings ***
#Documentation       Robot Framework Demo
#
#Library             Collections
#Library             String
#Library             JSONLibrary
#Library             RequestsLibrary
#
#*** Variables ***
#${base_url}         https://reqres.in
#
#*** Test Cases ***
#Get Request Demo
#    [Tags]          Demo
#    # Create a session for the API requests
#    Create Session  session1    ${base_url}    disable_warnings=1
#
#    # Define the endpoint and send a GET request
#    ${endpoint}=     Set Variable    /api/users?page=2
#    ${response}=     GET On Session  session1    ${endpoint}
#
#    # Log the response details
#    Log To Console   ${response.headers}
#    Log To Console   ${response.status_code}
#    Log To Console   ${response.content}
#
#    # Validation
#    ${status_code}=  Convert To String    ${response.status_code}
#    Should Be Equal  ${status_code}      200
#
#    # Parse the JSON response
#    ${json_response}=  Evaluate   json.loads('''${response.content}''')   json
#    ${page}=           Get From Dictionary  ${json_response}   page
#
#    # Convert extracted value to string for comparison
#    ${page_as_string}=   Convert To String    ${page}
#    Should Be Equal      ${page_as_string}    2
#
#    ${header_value}=     Get From Dictionary  ${response.headers}   Content-Type
#    Should Be Equal      ${header_value}      application/json; charset=utf-8









#Test POST Request
*** Comments ***
*** Settings ***
Documentation       Robot Framework Demo - POST Request Example
Library             Collections
Library             JSONLibrary
Library             RequestsLibrary

*** Variables ***
${base_url}         https://reqres.in

*** Test Cases ***
Test POST Request
    [Tags]          Demo
    # Create a session for the API requests
    Create Session  session1    ${base_url}    disable_warnings=1

    # Define the endpoint and the payload
    ${endpoint}=     Set Variable    /api/users
    ${payload}=      Create Dictionary    name=John Doe    job=Developer

    # Send a POST request
    ${response}=     POST On Session   session1    ${endpoint}    json=${payload}

    # Log response details
    Log To Console   ${response.headers}
    Log To Console   ${response.status_code}
    Log To Console   ${response.content}

    # Validate the response status code
    ${status_code}=  Convert To String    ${response.status_code}
    Should Be Equal  ${status_code}      300
    Should Be Equal  ${status_code}      400            #rajbranch changes

    # Validate response content
    ${json_response}=  Evaluate   json.loads('''${response.content}''')   json
    ${name}=           Get From Dictionary   ${json_response}   name
    ${job}=            Get From Dictionary   ${json_response}   job

    Should Be Equal    ${name}     John Doe
    Should Be Equal    ${job}      Developer
