*** Settings ***
Library    Browser
Library    Collections
Suite Setup    Open Browser and navigate to URL
Suite Teardown    Close The Browser

*** Variables ***
${BROWSER}    chromium
${URL}        https://letcode.in/dropdowns

@{fruits}       Select Fruit    Apple    Mango    Orange    Banana    Pine Apple

# Locators
${fruits_dropdown}        //select[@id="fruits"]

*** Test Cases ***
Validate Dropdown Operations
    Validate Dropdown is visible
    Validate Dropdown is enabled
    Validate all the Expected values are displayed in the dropdown
    Validate Expected Value is selected by default
    Validate Value can be selected by label
    Validate Value can be selected by index
    Validate Value can be selected by value

*** Keywords ***
Open Browser and navigate to URL
    New Browser    ${BROWSER}    headless=False
    New Page    ${URL}

Validate Dropdown is visible
    Wait For Elements State    ${fruits_dropdown}    visible

Validate Dropdown is enabled
    Wait For Elements State    ${fruits_dropdown}    enabled
    
Validate all the Expected values are displayed in the dropdown


    # Fetched values will return as dictionary, we need to extract the labels from the dictionary
    ${fetched_values}    Get Select Options        ${fruits_dropdown}
    ${labels}=    Create List
    FOR    ${option}    IN    @{fetched_values}
        ${label}=    Get From Dictionary    ${option}    label
        Append To List    ${labels}    ${label}
    END

    FOR  ${value}  IN  @{fruits}
        List Should Contain Value    ${labels}    ${value}
    END

Validate Expected Value is selected by default
    ${expected_value}=    Set Variable    Select Fruit
    ${selected_values}    Get Selected Options     ${fruits_dropdown}
    FOR  ${fruit}   IN  @{fruits}
        IF  '${fruit}' == '${expected_value}'
            List Should Contain Value    ${selected_values}    ${fruit}
        ELSE
            List Should Not Contain Value    ${selected_values}    ${fruit}
        END
    END

Validate Value can be selected by label
    ${select_label}=    Set Variable    Mango
    Select Options By    ${fruits_dropdown}    label    ${select_label}
    ${selected_values}    Get Selected Options    ${fruits_dropdown}
    FOR  ${fruit}   IN  @{fruits}
        IF  '${fruit}' == '${select_label}'
            List Should Contain Value    ${selected_values}    ${fruit}
        ELSE
            List Should Not Contain Value    ${selected_values}    ${fruit}
        END
    END

Validate Value can be selected by index
    ${select_index}=    Set Variable    ${fruits}[3]
    Select Options By    ${fruits_dropdown}    index  3
    ${selected_values}    Get Selected Options    ${fruits_dropdown}
    FOR  ${fruit}   IN  @{fruits}
        IF  '${fruit}' == '${select_index}'
            List Should Contain Value    ${selected_values}    ${fruit}
        ELSE
            List Should Not Contain Value    ${selected_values}    ${fruit}
        END
    END

Validate Value can be selected by value
    ${select_value}=    Set Variable    ${fruits}[2]
    Select Options By    ${fruits_dropdown}    value    1
    ${selected_values}    Get Selected Options    ${fruits_dropdown}
    FOR  ${fruit}   IN  @{fruits}
        IF  '${fruit}' == '${select_value}'
            List Should Contain Value    ${selected_values}    ${fruit}
        ELSE
            List Should Not Contain Value    ${selected_values}    ${fruit}
        END
    END


Close The Browser
    Close Browser
