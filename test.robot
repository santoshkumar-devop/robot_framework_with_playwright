*** Settings ***
Library    Browser

*** Variables ***
${BROWSER}    chromium
${URL}        https://letcode.in/

*** Test Cases ***
Open Browser and Check Title
    New Browser    ${BROWSER}    headless=False
    New Page    ${URL}
    ${title}=    Get Title
    Should Be Equal    ${title}    LetCode with Koushik
    Close Browser
