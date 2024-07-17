*** Settings ***
Library    Browser
Library    Collections
Library    OperatingSystem
Suite Setup    Open Browser and navigate to URL
Suite Teardown    Close The Browser

*** Variables ***
${BROWSER}    chromium
${URL}        https://demoqa.com/upload-download

${DOWNLOAD_DIR}       ${OUTPUT DIR}/downloads
${EXPECTED_FILE}      ${DOWNLOAD_DIR}/sampleFile.jpeg

# Locators
${upload_file}        //input[@id="uploadFile"]
${download_file_link}    //a[@id="downloadButton"]


*** Test Cases ***

Validate Upload file Operations
    Validate Upload file link or button is visible
    Validate Upload file link or button is enabled
    Upload file and Validate File is Uploaded
    Upload file and Validate File is Uploaded - second way
    Validate Download file link or button is visible
    Validate Download file link or button is enabled
    Download File and Validate File is Downloaded

*** Keywords ***
Open Browser and navigate to URL
    New Browser    ${BROWSER}    headless=False
    New Page    ${URL}

Validate Upload file link or button is visible
    Wait For Elements State    ${upload_file}    visible

Validate Upload file link or button is enabled
    Wait For Elements State    ${upload_file}    enabled

Upload file and Validate File is Uploaded
    Create File         ${OUTPUT DIR}/upload_file.txt
    Upload File By Selector        ${upload_file}    upload_file.txt
    ${file_name}=    Get Text    ${upload_file}

    # Verify File is Uploaded
    ${uploaded_file}=    Set Variable    //p[@id="uploadedFilePath" and contains(., '${file_name}')]
    Wait For Elements State    ${uploaded_file}    visible
    Remove File    ${OUTPUT DIR}/upload_file.txt

Upload file and Validate File is Uploaded - second way
    Create File         ${OUTPUT DIR}/upload_file.txt
    ${promise}=    Promise To Upload File    upload_file.txt
    Click   ${upload_file}
    Wait For    ${promise}
    ${file_name}=    Get Text    ${upload_file}

    # Verify File is Uploaded
    ${uploaded_file}=    Set Variable    //p[@id="uploadedFilePath" and contains(., '${file_name}')]
    Wait For Elements State    ${uploaded_file}    visible
    Remove File    ${OUTPUT DIR}/upload_file.txt

Validate Download file link or button is visible
    Wait For Elements State    ${download_file_link}    visible

Validate Download file link or button is enabled
    Wait For Elements State    ${download_file_link}    enabled

Download File and Validate File is Downloaded
    ${download_promise}=    Promise To Wait For Download    saveAs=${EXPECTED_FILE}    wait_for_finished=True
    Click    ${download_file_link}
    File Should Exist    ${EXPECTED_FILE}

Close The Browser
    Close Browser
