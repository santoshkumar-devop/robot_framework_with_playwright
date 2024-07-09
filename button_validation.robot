*** Settings ***
Library    Browser
Suite Setup    Open Browser and navigate to URL
Suite Teardown    Close The Browser

*** Variables ***
${BROWSER}    chromium
${URL}        https://letcode.in/buttons
${HOME_PAGE}    https://letcode.in/

# Locators
${home_button}        //button[@id='home']
${disabled_button}    //button[@id="isDisabled" and contains(., 'Disabled')]

*** Test Cases ***

Validate Button Operations
    Verify Button is Visible
    Verify Button is Enabled
    Verify Button is Clickable
    Verify Button is Disabled
    Verify Button is Not Clickable

*** Keywords ***
Open Browser and navigate to URL
    New Browser    ${BROWSER}    headless=False
    New Page    ${URL}

Verify Button is Visible
    Wait For Elements State    ${home_button}    visible
    
Verify Button is Enabled
    Wait For Elements State    ${home_button}    enabled

Verify Button is Clickable
    Click    ${home_button}
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${HOME_PAGE}
    Go To    ${URL}

Verify Button is Disabled
    Wait For Elements State    ${disabled_button}    disabled
    
Verify Button is Not Clickable
    ${element_state}=    Get Attribute    ${disabled_button}    disabled
    Should Be True    '${element_state}' != 'None'

Close The Browser
    Close Browser
