*** Settings ***
Library    Browser
Suite Setup    Open Browser and navigate to URL
Suite Teardown    Close The Browser

*** Variables ***
${BROWSER}    chromium
${URL}        https://letcode.in/edit

# Locators
${label}                 //label[@for='name' and contains(., 'Enter your full Name')]
${fullname_textbox}      //input[@id="fullName"]
${disabled_textbox}      //input[@id="noEdit"]
${readonly_textbox}      //input[@id="dontwrite"]


*** Test Cases ***
Validate Textbox Operations
    Verify Label is Visible
    Verify Text Box is Visible
    Verify Text Box is Enabled
    Verify Text Box is Disabled
    Verify Text Box is Readonly
    Verify Text Box is Empty
    Enter The Text
    Verify Entered text is correct
    Clear The Text
    Verify Text Box is Empty
    Update the Text
    Verify Text is Updated
    Take a Screenshot


*** Keywords ***
Open Browser and navigate to URL
    New Browser    ${BROWSER}    headless=False
    New Page    ${URL}

Verify Label is Visible
    Wait For Elements State    ${label}     visible

Verify Text Box is Visible
    Wait For Elements State    ${fullname_textbox}    visible
    
Verify Text Box is Enabled
    Wait For Elements State    ${fullname_textbox}    enabled

Verify Text Box is Disabled
    Wait For Elements State    ${disabled_textbox}    disabled

Verify Text Box is Readonly
    Wait For Elements State    ${readonly_textbox}    readonly
        
Verify Text Box is Empty
    ${text}=    Get Text    ${fullname_textbox}
    Should Be Empty    ${text}

Enter The Text
    Type Text    ${fullname_textbox}    Bharat

Verify Entered text is correct
    ${text}=    Get Text    ${fullname_textbox}
    Should Be Equal    ${text}    Bharat
    
Clear The Text
    Clear Text    ${fullname_textbox}
    ${text}=    Get Text    ${fullname_textbox}
    Should Be Empty    ${text}

Update the Text
    Enter The Text
    ${text}=    Get Text    ${fullname_textbox}
    ${new_text}=    Set Variable    ${text} Updated
    Clear Text    ${fullname_textbox}
    Type Text    ${fullname_textbox}    ${new_text}

Verify Text is Updated
    ${text}=    Get Text    ${fullname_textbox}
    Should Be Equal    ${text}    Bharat Updated

Take a Screenshot
    Take Screenshot    text_box_operations.png

Close The Browser
    Close Browser
