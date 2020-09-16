*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${url}            https://dev.youredi.com/
${password}       N9ScmaA$BRDalQbm$Gn9XmNZKcQ!
${email}          komal@youredi.com

*** Test Cases ***
Dev_TC01_AddProcess
    [Documentation]    Check that If Process does not exist , it should get added successfully
    ...
    ...    Test Data Setup
    ...    1. Need Organization Name : Komal test organistaion
    ...    2. Need Service -- DemoService
    Open Browser    ${url}    chrome
    Input Text    id=email    ${email}
    Input Password    id=password    ${password}
    Click Element    class=fa-sign-in
    Sleep    9s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]    # Selects Service
    Click Element    class=fa-object-group    #Click Processes
    Sleep    6s
    Capture Page Screenshot
    Click Element    xpath=//*[@id="webide"]/main/section/section/header/button[1]    #Clicks Add Process button
    Sleep    6s
    Input Text    name=processName    1Process    #Provide new process name
    Sleep    6s
    Capture Page Screenshot
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div/div[2]/form/button    #Click Save
    Sleep    8s
    Page should contain element    class=fa-play    #New process page should be displayed with Start button
    Capture Page screenshot
    close browser

Dev_TC02_DeleteProcess_PositiveScenario
    [Documentation]    Check that user is able to delete the process if process name entered on Delete pop up window is correct
    ...
    ...    Test data setup
    ...    Need process- 1Process added to DemoService in Komal test organistaion
    Open Browser    ${url}    chrome
    Input Text    id=email    ${email}
    Input Password    id=password    ${password}
    Click Element    class=fa-sign-in
    Sleep    9s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    8s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]
    Click Element    class=fa-object-group    # Clicks Processes
    Sleep    6s
    ${process}=    Get Text    xpath=//*[@id="webide"]/main/section/section/article/table/tbody/tr[1]/td[2]/a    #Gets name of the process that will be deleted
    Capture Page Screenshot
    Click Element    xpath=//*[@id="webide"]/main/section/section/article/table/tbody/tr[1]/td[9]/div/button    #Click delete
    Sleep    6s
    Input Text    xpath=//*[@id="input-8"]    ${process}    #Enter process name on delete pop up window
    Sleep    10s
    Click Element    xpath=//*[@id="webide"]/div[4]/form/div/div[3]/span/button[1]
    Sleep    10s
    Capture Page Screenshot
    close browser

Dev_TC03_DeleteProcess_ProcessNameIncorect
    [Documentation]    Check that delete button should not be active if On delete window,process name entered is incorrect
    ...
    ...    Test Data setup
    ...    1. Komal test organistaion \ -- DemoService
    Open Browser    ${url}    chrome
    Input Text    id=email    ${email}
    Input Password    id=password    ${password}
    Click Element    class=fa-sign-in
    Sleep    9s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    8s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]    #Select Service
    Click Element    class=fa-object-group    #Click on Processes
    Sleep    6s
    Click Element    xpath=//*[@id="webide"]/main/section/section/article/table/tbody/tr[1]/td[9]/div/button    #Click on delete button in first row
    Sleep    6s
    Input Text    xpath=//*[@id="input-8"]    8134 Bug    # enter incorrect process name in delete popup window
    Sleep    10s
    Element Should Be Disabled    xpath=//*[@id="webide"]/div[4]/form/div/div[3]/span/button[1]    #Check that delete button should be disabled
    Capture Page Screenshot
    close browser

Dev_TC04_DeleteProcess_Cancel
    [Documentation]    Check that user if User clicks on cancel button on Delete process page, then process should not get deleted
    ...
    ...
    ...    Test Data setup
    ...    1. Komal test organistaion \ -- DemoService
    Open Browser    ${url}    chrome
    Input Text    id=email    ${email}
    Input Password    id=password    ${password}
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    8s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]    # select service
    Click Element    class=fa-object-group    # click on processes
    Sleep    6s
    ${process}=    Get Text    xpath=//*[@id="webide"]/main/section/section/article/table/tbody/tr[1]/td[2]/a    #get the process name to be deleted
    Capture Page Screenshot
    Click Element    xpath=//*[@id="webide"]/main/section/section/article/table/tbody/tr[1]/td[9]/div/button    # click delete button
    Sleep    6s
    Input Text    xpath=//*[@id="input-8"]    ${process}    # get in the process name to be deleted
    Sleep    10s
    Capture Page Screenshot
    Click Element    xpath=//*[@id="webide"]/div[4]/form/div/div[3]/span/button[2]    # click cancel on delete pop up window
    Sleep    10s
    Capture Page Screenshot
    Page should contain    text=${process}
    Close browser

Dev_TC05_DeleteEndpoint_Positive
    [Documentation]    Check that If endpoint is not assoicated to a process, then it should get deleted
    ...
    ...    Test Data setup
    ...    1. Komal test organistaion \ -- DemoService \ -- 1Process
    Open Browser    ${url}    chrome
    Input Text    id=email    ${email}
    Input Password    id=password    ${password}
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    8s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]
    Click Element    class=fa-lightbulb-o    #Click endpoints
    Sleep    6s
    Capture Page screenshot
    Click Element    xpath=//*[@id="webide"]/main/section/section/form/header/div/button    #click delete button
    Sleep    6s
    Click Element    xpath=//*[@id="webide"]/div[4]/form/div/div[3]/span/button[1]    #confirm deletion
    Sleep    6s
    Capture Page Screenshot
    close browser

Dev_TC06_AddProcess_Negative_ProcessAlreadyExist
    [Documentation]    Check that process should not get added if Process name or endpoint name already exist
    ...
    ...
    ...    Test Data Setup
    ...    1. Need Organization -- Name : Komal test organistaion
    ...    2. Need Service -- DemoService
    Open Browser    ${url}    chrome
    Input Text    id=email    ${email}
    Input Password    id=password    ${password}
    Click Element    class=fa-sign-in
    Sleep    9s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    sleep    8s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]
    Click Element    class=fa-object-group    # Click on processes
    Sleep    6s
    Capture Page screenshot
    Click Element    xpath=//*[@id="webide"]/main/section/section/header/button[1]    # click on add process
    Sleep    6s
    Input Text    name=processName    ProcessNew12121    # try adding adding process that already exist
    Sleep    6s
    Capture page screenshot
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div/div[2]/form/button    # click save button
    Sleep    6s
    Page should not contain element    class=fa-play    # Error message should be displayed
    Capture Page screenshot
    close browser

Dev_TC07_DeleteEndpoint_Negative_EndpointAssociatedToProcess
    [Documentation]    Check that If endpoint is associated to a process , endpoint should not get deleted
    ...
    ...
    ...    Test Data Setup
    ...    1. Need Organization -- Name : Komal test organistaion
    ...    2. Need Service -- DemoService
    Open Browser    ${url}    chrome
    Input Text    id=email    ${email}
    Input Password    id=password    ${password}
    Click Element    class=fa-sign-in    # Login
    Sleep    9s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    8s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]
    Click Element    class=fa-lightbulb-o    # Click on Endpoints
    Sleep    6s
    Capture Page screenshot
    Click Element    xpath=//*[@id="webide"]/main/section/section/form/header/div/button    # click on delete enpoint
    Sleep    6s
    Click Element    xpath=//*[@id="webide"]/div[4]/form/div/div[3]/span/button[1]    # confirm deletion on endpoint
    Sleep    6s
    Capture Page Screenshot
    Page Should contain    text=Can't delete an endpoint that has a process attached    # error message should be displayed since endpoint associated to a process
    close browser

Dev_TC08_AddEndpoint_Positive
    [Documentation]    Check user can add endpoint if it does not already exist
    ...
    ...
    ...    Test Data Setup
    ...    1. Need Organization -- Name : Komal test organistaion
    ...    2. Need Service -- DemoService
    Open Browser    ${url}    chrome
    Input Text    id=email    ${email}
    Input Password    id=password    ${password}
    Click Element    class=fa-sign-in
    Sleep    9s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    9s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]
    Click Element    class=fa-lightbulb-o    # click on endpoints
    Sleep    6s
    Capture Page screenshot
    Click Element    xpath=//*[@id="webide"]/main/section/section/section/header/button[1]/i    # click on add endpoint
    Sleep    6s
    Input text    name=Description    3Endpoint    # enter new endpoint name
    click element    xpath=//*[@id="webide"]/main/section/section/form/header/button    # save the endpoint
    Sleep    6s
    Click Element    xpath=//*[@id="webide"]/main/section/section/section/header/button[2]    # refresh endpoints
    close browser

Dev_TC09_ServiceDataPage
    [Documentation]    Check Service data UI page
    ...
    ...
    ...    Test Data Setup
    ...    1. Need Organization -- Name : Komal test organistaion
    ...    2. Need Service -- DemoService2
    ...
    ...    Service data should be set with following values
    ...    ItemType2
    ...    Index1 as In2
    ...    Index2 as Dex2
    ...
    ...    Data as DataResult
    Open Browser    ${url}    chrome
    Input Text    id=email    ${email}
    Input Password    id=password    ${password}
    Click Element    class=fa-sign-in
    Sleep    9s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    8s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[2]/div/p/a[2]    #Select Service
    Sleep    6s
    Click Element    xpath=//*[@id="webide"]/aside/div[1]/ul/li[14]/a/i    # click on Service data link
    Sleep    6s
    Capture Page Screenshot
    Input Text    name=itemType    Type2    # enter item type
    Input Text    name=index1    In2    # enter index1
    Input Text    name=index2    Dex2    # enter index 2
    Click Element    xpath=//*[@id="webide"]/main/section/section/form/header/button/i
    Sleep    8s
    capture page screenshot
    Page should contain    text=DataResult    # Service Data - Data should fe fetched

Dev_TC10_AddServiceParameter_Positive
    [Documentation]    Check user can add Service parameter on Parameter UI page
    ...
    ...
    ...    Test Data Setup
    ...    1. Need Organization -- Name : Komal test organistaion
    ...    2. Need Service -- DemoService
    Open Browser    ${url}    chrome
    Input Text    id=email    ${email}
    Input Password    id=password    ${password}
    Click Element    class=fa-sign-in
    Sleep    9s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]
    Click Element    class=fa-cogs    # Click on Parameters link
    Sleep    6s
    Capture Page screenshot
    Click Element    xpath=//*[@id="webide"]/main/section/section/section/header/button[1]    # click on Add parameter
    Sleep    6s
    Input Text    name=ID    1parameter    # enter parameter name
    Execute javascript    _editor = document.querySelectorAll("div.CodeMirror")[0].CodeMirror;    _editor.setValue("Value for Key1")    # set value for parameter
    Sleep    5s
    Capture Page Screenshot
    Click element    xpath=//*[@id="webide"]/main/section/section/form/header/div[1]/button    # click save button
    sleep    6s
    Capture Page Screenshot
    Click element    xpath=//*[@id="webide"]/main/section/section/section/header/button[2]/i    # click refresh
    Sleep    6s
    Page should contain    text=1parameter    # check that page should display new parameter added

Dev_TC11_DeleteParameter
    [Documentation]    Check user can delete service parameter
    ...
    ...    Test Data Setup
    ...    1. Need Organization -- Name : Komal test organistaion
    ...    2. Need Service -- DemoService
    Open Browser    ${url}    chrome
    Input Text    id=email    ${email}
    Input Password    id=password    ${password}
    Click Element    class=fa-sign-in
    Sleep    9s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    9s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]    # select service
    Click Element    class=fa-cogs    # click on paramters
    Sleep    6s
    Capture Page screenshot
    Click Element    xpath=//*[@id="webide"]/main/section/section/form/header/div[2]/button/i    # click on delete button
    Sleep    6s
    Capture page screenshot
    Click Element    xpath=//*[@id="webide"]/div[4]/form/div/div[3]/span/button[1]/i    # confirm deletion
    Sleep    6s
    Capture Page Screenshot

Dev_TC12_AddCrossReference_Positive
    [Documentation]    Check user can add Cross reference key on UI
    ...
    ...    Test Data Setup
    ...    1. Need Organization -- Name : Komal test organistaion
    ...    2. Need Service -- DemoService
    Open Browser    ${url}    chrome
    Input Text    id=email    ${email}
    Input Password    id=password    ${password}
    Click Element    class=fa-sign-in
    Sleep    9s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]
    Click Element    class=fa-table    # click on cross reference
    Sleep    6s
    Capture Page screenshot
    Click Element    xpath=//*[@id="webide"]/main/section/section/section[1]/header/button[1]    # click on add cross reference table
    Sleep    6s
    Input Text    name=newTableName    Table1    # Add a table name
    Sleep    6s
    capture page screenshot
    click element    xpath=//*[@id="webide"]/div[5]/form/div/div[3]/div/button[1]
    sleep    6s
    Input Text    name=crossReference.Key    key1122
    Execute javascript    _editor = document.querySelectorAll("div.CodeMirror")[0].CodeMirror;    _editor.setValue("Value for Key1122")
    Sleep    5s
    Capture Page Screenshot
    Click element    xpath=//*[@id="webide"]/main/section/section/section[2]/form[1]/header/button
    sleep    6s
    Capture Page Screenshot

Dev_TC13_Delete_CrossReferenceKey
    [Documentation]    Check user can delete Cross reference key on UI
    Open Browser    ${url}    chrome
    Input Text    id=email    ${email}
    Input Password    id=password    ${password}
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]    #Select Service
    Click Element    class=fa-table    #Click on Cross Reference
    Sleep    6s
    Capture Page screenshot
    Click Element    xpath=//*[@id="webide"]/main/section/section/section[2]/form[1]/header/div/button/i
    Sleep    6s
    Capture Page Screenshot
    Click Element    xpath=//*[@id="webide"]/div[4]/form/div/div[3]/span/button[1]
    Sleep    6s
    Capture Page Screenshot
    Click element    xpath=//*[@id="webide"]/main/section/section/section[1]/header/button[2]
    sleep    6s
    Capture Page Screenshot
    close browser

Dev_TC14_Delete_Counter
    [Documentation]    Check user can delete Counter on UI
    Open Browser    ${url}    chrome
    Input Text    id=email    ${email}
    Input Password    id=password    ${password}
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]
    Click Element    class=fa-calculator    #Click on Counters
    Sleep    6s
    Capture Page screenshot
    Click Element    xpath=//*[@id="webide"]/main/section/section/section/table/tbody/tr/td[3]/div/button/i    #Click Delete
    Sleep    6s
    Capture Page Screenshot
    Click Element    xpath=//*[@id="webide"]/div[4]/form/div/div[3]/span/button[1]/i    #Click Delete on confimation
    Sleep    6s
    Capture Page Screenshot
    close browser

Dev_TC15_Search_Counter
    [Documentation]    Check user can search Counter on UI
    Open Browser    ${url}    chrome
    Input Text    id=email    ${email}
    Input Password    id=password    ${password}
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]    #Select Service
    Click Element    class=fa-calculator    # Click on counters
    Sleep    6s
    Capture Page screenshot
    Input text    name=filterName    Counter3    # Enter Counter3 in Search
    Click element    xpath=//*[@id="webide"]/main/section/section/form/header/div[2]/button/i    #Click refresh
    Sleep    6s
    Capture Page Screenshot
    Page should contain Element    class=fa-remove
    Close browser

Dev_TC16_Add And Delete Extension
    [Documentation]    Check user add and Delete extension if it is not associated to a process
    Open Browser    ${url}    chrome
    Input Text    id=email    ${email}
    Input Password    id=password    ${password}
    Click Element    class=fa-sign-in
    Sleep    9s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i    #Select Organization
    sleep    6s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]    # Select service
    Click Element    class=fa-plug    #Click extension
    Sleep    6s
    Capture Page screenshot
    Click Element    xpath=//*[@id="webide"]/main/section/section/section/header/button[1]/i    # Click on Add
    Sleep    6s
    Input Text    name=extension.Name    Ext2    #Enter Extension name
    Sleep    6s
    Capture Page Screenshot
    Click Element    xpath=//*[@id="webide"]/main/section/section/form/header/button[1]    #Click save
    sleep    6s
    Capture Page Screenshot
    click element    xpath=//*[@id="webide"]/main/section/section/form/header/div/button/i    #Click delete
    Sleep    6s
    Click Element    xpath=//*[@id="webide"]/div[4]/form/div/div[3]/span/button[1]/i    # Confirm deletion
    Sleep    6s
    Capture Page screenshot
    close browser

Dev_TC17_Add Library
    [Documentation]    Check user can add Library
    Open Browser    ${url}    chrome
    Input Text    id=email    ${email}
    Input Password    id=password    ${password}
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i    #Select organization
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]    #Select Service
    Click Element    class=fa-book    #Click on Library
    Sleep    6s
    Capture Page screenshot
    Click Element    xpath=//*[@id="webide"]/main/section/section/section/header/button[1]/i    #Click on Add
    Sleep    6s
    Input Text    name=Name    Default1    #Enter Library Name
    Sleep    6s
    Capture Page Screenshot
    Click element    xpath=//*[@id="webide"]/main/section/section/form/header/button/i    #Click Save
    Sleep    8s
    Capture page screenshot
    Element should be Enabled    class=fa-refresh    #Click refresh
    close browser

Dev_TC18_Delete Library
    [Documentation]    Check user can delete library
    Open Browser    ${url}    chrome
    Input Text    id=email    ${email}
    Input Password    id=password    ${password}
    Click Element    class=fa-sign-in
    Sleep    9s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i    #Select Organization
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]    #Select Service
    Click Element    class=fa-book    #Click on Library
    Sleep    6s
    Capture Page screenshot
    Click Element    xpath=//*[@id="webide"]/main/section/section/form/header/div/button/i    #Click on delete
    Sleep    6s
    Click element    xpath=//*[@id="webide"]/div[4]/form/div/div[3]/span/button[1]/i    #Confirm deletion
    Sleep    6s
    Capture Page Screenshot
    close browser

Dev_TC21-Alerts_FilterByInfo
    [Documentation]    Check user can filter Alerts by Info
    Open Browser    ${url}    chrome
    Input Text    id=email    ${email}
    Input Password    id=password    ${password}
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i    #Select Organization
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]    # Select Service
    Click Element    class=fa-bell    #Click on Alerts
    Sleep    6s
    capture page screenshot
    Input text    name=filterInfo    Info3    # Enter into filter criteria
    Sleep    7s
    Click element    xpath=//*[@id="webide"]/main/section/section/header/form/div[4]/button/i
    Sleep    6s
    Click element    xpath=//*[@id="webide"]/main/section/section/section/section[1]/section[1]/article/ul/li[2]
    Sleep    6s
    Capture page Screenshot
    Page should not contain    text=No alerts found
    close browser

Dev_TC25-Logs-information
    [Documentation]    Check user can Filter Logs by information
    Open Browser    ${url}    chrome
    Input Text    id=email    ${email}
    Input Password    id=password    ${password}
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]
    Click Element    class=fa-info-circle
    Sleep    6s
    capture page screenshot
    Input text    name=filterInformation    Hii
    Sleep    7s
    Capture page Screenshot
    Page should not contain    text=hello
    page should contain    text=Hii
    close browser

Dev_TC28-Logout
    [Documentation]    Check user can logout from the application
    Open Browser    ${url}    chrome
    Input Text    id=email    ${email}
    Input Password    id=password    ${password}
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    capture page screenshot
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[2]/div/p/i
    capture page screenshot
    Click element    class=fa-cog
    Click element    xpath=//*[@id="webide"]/aside/div[2]/div/a[5]/i
    Handle Alert
    Sleep    6s
    Page should contain element    xpath=//*[@id="login"]/div/div[1]/div[2]/form/div[4]/div/button/i

Dev_TC34_AddUserToOrganization
    [Documentation]    Check we can add User to Organisation
    ...
    ...    Test data setup
    ...    Komal test organisation
    Open Browser    ${url}    chrome
    Input Text    id=email    ${email}
    Input Password    id=password    ${password}
    Click Element    class=fa-sign-in
    Sleep    9s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    6s
    click element    xpath=//*[@id="webide"]/main/section/section/div/div[2]/div[1]/p/a[2]
    Sleep    6s
    Click element    xpath=//*[@id="webide"]/aside/div[1]/ul/li[1]/span[2]/a/i
    Click element    xpath=//*[@id="webide"]/main/section/section/section/section/header/button[1]/i
    Sleep    6s
    Input Text    xpath=/html/body/main/section/section/section/section/div/div/div[2]/form/div/div/input    aryan@youredi.com
    Sleep    6s
    Click element    xpath=//*[@id="webide"]/main/section/section/section/section/div/div/div[2]/form/div/div/span/span/button/i
    Sleep    6s
    Click element    xpath=//*[@id="webide"]/main/section/section/section/section/div/div/div[2]/form/div[2]/button/i
    sleep    6s
    capture page screenshot
    Click element    xpath=//*[@id="webide"]/main/section/section/section/form/header/button/i
    sleep    6s
    capture page screenshot

Dev_TC36_EditUserRoleInOrganization
    [Documentation]    Check that we can add role for the user for organisation
    Open Browser    ${url}    chrome
    Input Text    id=email    ${email}
    Input Password    id=password    ${password}
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    6s
    click element    xpath=//*[@id="webide"]/main/section/section/div/div[2]/div[1]/p/a[2]
    Sleep    6s
    capture page screenshot
    Click element    xpath=//*[@id="webide"]/aside/div[1]/ul/li[1]/span[2]/a/i
    sleep    6s
    Select from list by value    name=Role    Designer
    Sleep    6s
    Click element    xpath=//*[@id="webide"]/main/section/section/section/form/header/button/i
    Sleep    6s
    capture page screenshot

Dev_TC35_DeleteUserFromOrganization
    [Documentation]    check that we can delete user from organisation
    Open Browser    ${url}    chrome
    Input Text    id=email    ${email}
    Input Password    id=password    ${password}
    Click Element    class=fa-sign-in
    Sleep    9s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    6s
    click element    xpath=//*[@id="webide"]/main/section/section/div/div[2]/div[1]/p/a[2]
    Sleep    6s
    Capture page screenshot
    Click element    xpath=//*[@id="webide"]/aside/div[1]/ul/li[1]/span[2]/a/i
    Sleep    6s
    Click element    xpath=//*[@id="webide"]/main/section/section/section/form/header/div/button/i
    Sleep    6s
    Capture page screenshot
    Click element    xpath=//*[@id="webide"]/div[4]/form/div/div[3]/span/button[1]/i
    Sleep    6s
    Capture page screenshot
    Page should not contain    text=Aryan

Dev_TC44_ServiceDataPage_Index2NotMandatory
    [Documentation]    Check that index2 is not mandatory on Service data page
    ...
    ...
    ...    Test Data Setup
    ...    1. Need Organization -- Name : Komal test organistaion
    ...    2. Need Service -- DemoService2
    ...
    ...    Service data with Item Type as Type2 and Index1 as In2
    ...    Data should be DataResult
    Open Browser    ${url}    chrome
    Input Text    id=email    ${email}
    Input Password    id=password    ${password}
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    8s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[2]/div/p/a[2]
    Sleep    6s
    Click Element    xpath=//*[@id="webide"]/aside/div[1]/ul/li[14]/a/i
    Sleep    6s
    Capture Page Screenshot
    Input Text    name=itemType    Type2
    Input Text    name=index1    In2
    Click Element    xpath=//*[@id="webide"]/main/section/section/form/header/button/i
    Sleep    6s
    capture page screenshot
    Page should contain    text=DataResult

Dev_TC51_Check If binding is not active process should not get executed
    [Documentation]    Check if the endpoint binding is not active, process should not get executed.An error message should be displayed
    ...
    ...
    ...    Test Data Setup
    ...    1. Need Organization Name : Komal test organistaion
    ...    2. Need Service -- DemoService
    ...    3 Process name binding whose endpoint binding is not marked active
    Open Browser    ${url}    chrome
    Input Text    id=email    ${email}
    Input Password    id=password    ${password}
    Click Element    class=fa-sign-in
    Sleep    8s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    8s
    Click element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Sleep    6s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[2]/div/p/a[2]    #Select service
    Sleep    6s
    Click element    class=fa-object-group    #Click on Processes
    Sleep    9s
    click element    xpath=//*[@id="webide"]/main/section/section/article/table/tbody/tr[1]/td[2]/a    #Select Binding process
    Sleep    6s
    click element    xpath=//*[@id="webide"]/main/section[1]/header/div/button/i    #click start
    sleep    9s
    click element    xpath=//*[@id="webide"]/main/section[1]/div[1]/div[1]/div[1]/div/button[1]/i    #click start
    sleep    9s
    Page should contain    text=Process not found using given account    #error message shouldbe present
    capture page screenshot

