*** Settings ***
Library    Browser
Suite Setup    Open Browser and navigate to URL
Suite Teardown    Close The Browser

*** Variables ***
${BROWSER}    chromium
${URL}        https://letcode.in/radio

# Locators
${yes_radio}        //input[@id='one']
${no_radio}         //input[@id='two']
${disabled_radio}    //input[@id="maybe"]

*** Test Cases ***
Validate Radio Button Operations
    Verify Radio Buttons are Visible
    Verify Radio Buttons are Enabled or Clickable
    Verify By default Radio Button is Not Selected
    Verify By default Radio Button is Not Selected - second way
    Verify Radio Button is Selected
    Verify Radio Button is Selected - second way
    Verify Radio Button is Not Selected
    Verify Radio Button is Not Selected - second way
    Verify Radio Button is Not Clickable
    Verify Radio Button is Not Clickable - second way


*** Keywords ***
Open Browser and navigate to URL
    New Browser    ${BROWSER}    headless=False
    New Page    ${URL}

Verify Radio Buttons are Visible
    Wait For Elements State    ${yes_radio}    visible
    Wait For Elements State    ${no_radio}    visible

Verify Radio Buttons are Enabled or Clickable
    Wait For Elements State    ${yes_radio}    enabled
    Wait For Elements State    ${no_radio}    enabled

Verify By default Radio Button is Not Selected
    ${element}=    Get Element    ${no_radio}
    ${element_state}=    Get Property    ${element}    checked
    Should Be True    '${element_state}' == 'False'

Verify By default Radio Button is Not Selected - second way
    Wait For Elements State    ${no_radio}    unchecked

Verify Radio Button is Selected
    Click    ${no_radio}
    ${element}=    Get Element    ${no_radio}
    ${element_state}=    Get Property    ${element}    checked
    Should Be True    '${element_state}' == 'True'

Verify Radio Button is Selected - second way
    Click    ${no_radio}
    Wait For Elements State    ${no_radio}    checked
    
Verify Radio Button is Not Selected
    ${element}=    Get Element    ${yes_radio}
    ${element_state}=    Get Property    ${element}    checked
    Should Be True    '${element_state}' == 'False'

Verify Radio Button is Not Selected - second way
    Wait For Elements State    ${yes_radio}    unchecked

Verify Radio Button is Not Clickable
    ${element_state}=    Get Attribute    ${disabled_radio}    disabled
    Should Be True    '${element_state}' != 'None'

Verify Radio Button is Not Clickable - second way
    Wait For Elements State    ${disabled_radio}    disabled

Close The Browser
    Close Browser
