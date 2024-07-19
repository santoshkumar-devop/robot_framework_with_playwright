*** Settings ***
Library    Browser
Library    Collections

*** Variables ***
${BROWSER}    chromium
${URL_1}        https://www.bing.com/
${URL}      https://www.google.com/

*** Test Cases ***
Validate The Browser Navigation Keywords
    Validate New Browser Keyword Functionality
    Validate New Page Keyword Functionality
    Validate Goto Keyword Functionality
    Validate Go Back Keyword Functionality
    Validate Go Forward Keyword Functionality
    Validate Switch Page Keyword Functionality
    Validate Close Page Keyword Functionality
    Validate Close Browser Keyword Functionality
    Validate Switch Browser Keyword Functionality
    Validate Reload Keyword Functionality
    Validate New Context Keyword Functionality
    Validate New Persistent Context Keyword Functionality

*** Keywords ***
Validate New Browser Keyword Functionality
    New Browser    ${BROWSER}    headless=${False}  slowMo=2
    Close Browser    # Close the browser

Validate New Page Keyword Functionality
    New Browser    ${BROWSER}    headless=${False}  slowMo=2
    New Page    ${URL}
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL}
    Close Browser    

Validate Goto Keyword Functionality
    New Browser    ${BROWSER}    headless=${False}  slowMo=2
    New Page    ${URL_1}
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL_1}

    Go to    ${URL}
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL}
    Close Browser    

Validate Switch Page Keyword Functionality
    New Browser    ${BROWSER}    headless=${False}  slowMo=2
    ${page_1}=    New Page    ${URL_1}
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL_1}
    
    ${page_2}=    New Page    ${URL}
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL}

    Switch Page    ${page_1}
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL_1}

    Switch Page    ${page_2}
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL}
    Close Browser    

Validate Go Back Keyword Functionality
    New Browser    ${BROWSER}    headless=${False}  slowMo=2
    New Page    ${URL}
    Go to    ${URL_1}
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL_1}

    Go Back
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL}
    Close Browser    

Validate Go Forward Keyword Functionality
    New Browser    ${BROWSER}    headless=${False}  slowMo=2
    New Page    ${URL}
    Go to    ${URL_1}
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL_1}

    Go Back
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL}

    Go Forward
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL_1}
    Close Browser

Validate Close Page Keyword Functionality
    New Browser    ${BROWSER}    headless=${False}  slowMo=2
    New Page    ${URL}
    New Page    ${URL_1}
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL_1}

    Close Page
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL}
    Close Browser

Validate Close Browser Keyword Functionality
    New Browser    ${BROWSER}    headless=${False}  slowMo=2
    New Page    ${URL}
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL}
    Close Browser

Validate Switch Browser Keyword Functionality
    ${browsers}=    create list
    ${browser_1}=    New Browser    chromium    headless=${False}  slowMo=2
    New Page    ${URL}
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL}
    Append To List    ${browsers}    ${browser_1}

    ${browser_2}=    New Browser    firefox    headless=${False}  slowMo=2
    New Page    ${URL_1}
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL_1}
    Append To List    ${browsers}    ${browser_2}

    Switch Browser    ${browser_1}
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL}

    Switch Browser    ${browser_2}
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL_1}

    FOR  ${browser}    IN    @{browsers}
        Close Browser    ${browser}
    END


Validate Reload Keyword Functionality
    New Browser    ${BROWSER}    headless=${False}  slowMo=2
    New Page    ${URL}
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL}

    Reload
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL}
    Close Browser

Validate New Context Keyword Functionality
    New Browser    ${BROWSER}    headless=${False}  slowMo=2
    ${context_1}=  New Context
    ${page_1}=    New Page    ${URL}
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL}

    ${context_2}=  New Context
    ${page_2}=    New Page    ${URL_1}
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL_1}

    Switch Context    ${context_1}
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL}

    Switch Context    ${context_2}
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL_1}
    Close Browser

Validate New Persistent Context Keyword Functionality

    ${context_1}=  New Persistent Context    browser=${BROWSER}    headless=${False}    slowMo=2
    # keyword returns a tuple of browser id, context id and page details
    log  ${context_1[1]}
    Go To    ${URL}
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL}

    ${context_2}=  New Persistent Context    browser=${BROWSER}    headless=${False}    slowMo=2
    log  ${context_2[1]}
    Go To    ${URL_1}
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL_1}

    Switch Context        ${context_1[1]}
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL}

    Switch Context        ${context_2[1]}
    ${get_url}=    Get Url
    Should Be Equal    ${get_url}    ${URL_1}
    Close Browser
