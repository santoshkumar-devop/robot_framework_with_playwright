*** Settings ***
Library    Browser
Suite Setup    Open Browser and navigate to URL
Suite Teardown    Close The Browser

*** Variables ***
${BROWSER}    chromium
${URL}        https://letcode.in/radio

# Locators
${checkbox}        (//input[@type='checkbox'])[1]

*** Test Cases ***

Validate Checkbox Operations
    Validate Checkbox is Visible
    Validate Checkbox is Enabled
    Validate Checkbox is Selected By Default
    Validate Checkbox is Selected By Default - second way
    Validate Checkbox is Clickable - uncheck
    Validate Checkbox is Clickable - uncheck - second way
    Validate Checkbox is Checked
    Validate Checkbox is Checked - second way
    Validate Checkbox is Unchecked
    Validate Checkbox is Unchecked - second way


*** Keywords ***
Open Browser and navigate to URL
    New Browser    ${BROWSER}    headless=False
    New Page    ${URL}

Validate Checkbox is Visible
    Wait For Elements State    ${checkbox}    visible

Validate Checkbox is Enabled
    Wait For Elements State    ${checkbox}    enabled

Validate Checkbox is Selected By Default
    ${element}=    Get Element    ${checkbox}
    ${element_state}=    Get Property    ${element}    checked
    Should Be True    '${element_state}' == 'True'

Validate Checkbox is Selected By Default - second way
    Wait For Elements State    ${checkbox}    checked

Validate Checkbox is Clickable - uncheck
    Click    ${checkbox}
    ${element}=    Get Element    ${checkbox}
    ${element_state}=    Get Property    ${element}    checked
    Should Be True    '${element_state}' == 'False'

Validate Checkbox is Clickable - uncheck - second way
    Wait For Elements State    ${checkbox}    unchecked

Validate Checkbox is Checked
    Click    ${checkbox}
    ${element}=    Get Element    ${checkbox}
    ${element_state}=    Get Property    ${element}    checked
    Should Be True    '${element_state}' == 'True'

Validate Checkbox is Checked - second way
    Wait For Elements State    ${checkbox}    checked

Validate Checkbox is Unchecked
    Click    ${checkbox}
    ${element}=    Get Element    ${checkbox}
    ${element_state}=    Get Property    ${element}    checked
    Should Be True    '${element_state}' == 'False'

Validate Checkbox is Unchecked - second way
    Wait For Elements State    ${checkbox}    unchecked

Close The Browser
    Close Browser
