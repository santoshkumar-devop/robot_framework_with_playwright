*** Settings ***
Library    Browser
Library    Collections
Suite Setup    Open Browser and navigate to URL
Suite Teardown    Close The Browser

*** Variables ***
${BROWSER}    chromium
${URL}        https://letcode.in/selectable


# Locators
${multiselect}        //div[@id="container"]
${all_options}        //div[@id="container"]//*[@id='selectable']
${SELECTED_ATTRIBUTE}    ui-selected


*** Test Cases ***
Validate multiselect Operations
    Validate multiselect is visible
    Validate multiselect is enabled
    Validate all the Expected values are displayed in the multiselect
    Validate No Value is selected by default
    Validate No Value is selected by default - Second Way
    Validate Selected Value is Saved
    Validate Selected Value is Saved - Second Way

*** Keywords ***
Open Browser and navigate to URL
    New Browser    ${BROWSER}    headless=False
    New Page    ${URL}

Validate multiselect is visible
    Wait For Elements State    ${multiselect}    visible

Validate multiselect is enabled
    Wait For Elements State    ${multiselect}    enabled

Validate all the Expected values are displayed in the multiselect
    ${fetched_values}    Get Elements           ${all_options}
    ${multi_select_options}=    Create List
    FOR    ${option}    IN    @{fetched_values}
        ${multi_select_option}=    Get Text       ${option}
        Append To List    ${multi_select_options}    ${multi_select_option}
    END

    @{expected_values}    Create List    Selenium    Protractor    Appium    TestNg     Postman    Cypress
    ...   Webdriver.io    Testproject.io    LetCode
    FOR  ${value}  IN  @{expected_values}
        List Should Contain Value    ${multi_select_options}    ${value}
    END

Validate No Value is selected by default
    ${elements}=    Get Elements    ${all_options}
    ${selected_elements}=    Create List
    FOR    ${element}    IN    @{elements}
        ${class_attr}=    Get Attribute    ${element}    class
        Run Keyword If    '${SELECTED_ATTRIBUTE}' in '${class_attr}'    Append To List    ${selected_elements}    ${element}
    END
    Should Be Empty    ${selected_elements}

Validate No Value is selected by default - Second Way
    ${elements}=    Get Elements    ${all_options}
    FOR  ${element}    IN    @{elements}
        ${value}=    Get Text    ${element}
        ${xpath_selected}=    Set Variable    //*[@id='clour' and contains(., '${value}')]/parent::div[@class='ui-selectable ui-selected']
        Wait For Elements State    ${xpath_selected}    hidden
    END

Validate Selected Value is Saved
    @{all_values}    Create List    Selenium    Protractor    Appium    TestNg     Postman    Cypress   Webdriver.io    Testproject.io    LetCode
    @{select_options}    Create List    ${all_values[1]}    ${all_values[4]}

    FOR  ${value}  IN  @{select_options}
        ${select_value}=    Set Variable            //*[@id='clour' and contains(., '${value}')]
        # 'Meta' is command key in Mac ( for 'CMD' key)
        Keyboard Key    down    Meta
        Click    ${select_value}
        Keyboard Key    up    Meta
    END

    # Add the selected values to the list
    ${selected_elements}=    Create List
    ${elements}=    Get Elements    ${all_options}
    FOR    ${element}    IN    @{elements}
        ${class_attr}=    Get Attribute    ${element}    class
        Run Keyword If    '${SELECTED_ATTRIBUTE}' in '${class_attr}'    Append To List    ${selected_elements}    ${element}
    END
    
    # Verify the selected values
    ${index}=    Set Variable    0
    FOR  ${element}  IN  @{selected_elements}
        ${value}=    Get Text    ${element}
        Should Be Equal    ${select_options[${index}]}    ${value}
        ${index}=    Evaluate    ${index} + 1
    END
    Reload

Validate Selected Value is Saved - Second Way
    @{all_values}    Create List    Selenium    Protractor    Appium    TestNg     Postman    Cypress   Webdriver.io    Testproject.io    LetCode
    @{select_options}    Create List    ${all_values[1]}    ${all_values[4]}

    FOR  ${value}  IN  @{select_options}
        ${select_value}=    Set Variable            //*[@id='clour' and contains(., '${value}')]
        # 'Meta' is command key in Mac ( for 'CMD' key)
        Keyboard Key    down    Meta
        Click    ${select_value}
        Keyboard Key    up    Meta
    END
    
    # Add the selected values to the list
    ${selected_elements}=    Create List
    ${elements}=    Get Elements    ${all_options}
    FOR    ${element}    IN    @{elements}
        ${class_attr}=    Get Attribute    ${element}    class
        ${value}=    Get Text    ${element}
        Run Keyword If    '${SELECTED_ATTRIBUTE}' in '${class_attr}'    Append To List    ${selected_elements}    ${value}
    END
    
    # Verify the selected values
    ${index}=    Set Variable    0
    FOR  ${element}  IN  @{all_values}
        IF  '${element}' in ${selected_elements}
            ${xpath_selected}=    Set Variable    //*[@id='clour' and contains(., '${element}')]/parent::div[@class='ui-selectable ui-selected']
            Wait For Elements State    ${xpath_selected}    visible
        ELSE
            ${xpath_not_selected}=    Set Variable    //*[@id='clour' and contains(., '${element}')]/parent::div[@class='ui-selectable']
            Wait For Elements State    ${xpath_not_selected}    visible
        END
        ${index}=    Evaluate    ${index} + 1
    END
    
    
Close The Browser
    Close Browser
