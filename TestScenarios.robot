*** Settings ***
Library           SeleniumLibrary

*** Test Cases ***
TC01_AddProcess
    [Documentation]    Check that If Process does not exist , it should get added successfully
    ...
    ...    Test Data Setup
    ...    1. Need Organization Name : Komal test organistaion
    ...    2. Need Service -- DemoService
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
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

TC02_DeleteProcess_PositiveScenario
    [Documentation]    Check that user is able to delete the process if process name entered on Delete pop up window is correct
    ...
    ...    Test data setup
    ...    Need process- 1Process added to DemoService in Komal test organistaion
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
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

TC03_DeleteProcess_ProcessNameIncorect
    [Documentation]    Check that delete button should not be active if On delete window,process name entered is incorrect
    ...
    ...    Test Data setup
    ...    1. Komal test organistaion \ -- DemoService
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
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

TC04_DeleteProcess_Cancel
    [Documentation]    Check that user if User clicks on cancel button on Delete process page, then process should not get deleted
    ...
    ...
    ...    Test Data setup
    ...    1. Komal test organistaion \ -- DemoService
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
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

TC05_DeleteEndpoint_Positive
    [Documentation]    Check that If endpoint is not assoicated to a process, then it should get deleted
    ...
    ...    Test Data setup
    ...    1. Komal test organistaion \ -- DemoService \ -- 1Process
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
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

TC06_AddProcess_Negative_ProcessAlreadyExist
    [Documentation]    Check that process should not get added if Process name or endpoint name already exist
    ...
    ...
    ...    Test Data Setup
    ...    1. Need Organization -- Name : Komal test organistaion
    ...    2. Need Service -- DemoService
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
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

TC07_DeleteEndpoint_Negative_EndpointAssociatedToProcess
    [Documentation]    Check that If endpoint is associated to a process , endpoint should not get deleted
    ...
    ...
    ...    Test Data Setup
    ...    1. Need Organization -- Name : Komal test organistaion
    ...    2. Need Service -- DemoService
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in    # Login
    Sleep    6s
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
    Page Should contain    text=Errors    # error message should be displayed since endpoint associated to a process
    close browser

TC08_AddEndpoint_Positive
    [Documentation]    Check user can add endpoint if it does not already exist
    ...
    ...
    ...    Test Data Setup
    ...    1. Need Organization -- Name : Komal test organistaion
    ...    2. Need Service -- DemoService
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
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

TC09_ServiceDataPage
    [Documentation]    Check Service data UI page
    ...
    ...
    ...    Test Data Setup
    ...    1. Need Organization -- Name : Komal test organistaion
    ...    2. Need Service -- DemoService
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    8s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[2]/div/p/a[2]
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
    Page should contain    text=Data    # Service Data - Data should fe fetched

TC10_AddServiceParameter_Positive
    [Documentation]    Check user can add Service parameter on Parameter UI page
    ...
    ...
    ...    Test Data Setup
    ...    1. Need Organization -- Name : Komal test organistaion
    ...    2. Need Service -- DemoService
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
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

TC11_DeleteParameter
    [Documentation]    Check user can delete service parameter
    ...
    ...    Test Data Setup
    ...    1. Need Organization -- Name : Komal test organistaion
    ...    2. Need Service -- DemoService
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
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

TC12_AddCrossReference_Positive
    [Documentation]    Check user can add Cross reference key on UI
    ...
    ...    Test Data Setup
    ...    1. Need Organization -- Name : Komal test organistaion
    ...    2. Need Service -- DemoService
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
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

TC13_Delete_CrossReferenceKey
    [Documentation]    Check user can delete Cross reference key on UI
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
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

TC14_Delete_Counter
    [Documentation]    Check user can delete Counter on UI
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
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

TC15_Search_Counter
    [Documentation]    Check user can search Counter on UI
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
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

TC16_Add And Delete Extension
    [Documentation]    Check user add and Delete extension if it is not associated to a process
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i    #Select Organization
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

TC17_Add Library
    [Documentation]    Check user can add Library
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
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

TC18_Delete Library
    [Documentation]    Check user can delete library
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
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

TC19_Add Service
    [Documentation]    Check user can add Service
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Scroll element into view    class=btn-light
    Click Element    class=btn-light    # Click on Add Service
    Sleep    6s
    Input Text    name=ShortDescription    TestServiceRF20    # Enter service name
    Input Text    name=LongDescription    Test Add service    # enter service description
    Click element    xpath=//*[@id="webide"]/main/section/section/form/header/button[1]/i    #Click save
    Sleep    6s
    Click Element    xpath=//*[@id="btn-home"]/i
    Scroll element into view    class=btn-light
    Capture Page screenshot

TC20_Add_schedule
    [Documentation]    Check user can add Schedule
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]
    Click Element    class=fa-calendar    # Click on Schedule
    Sleep    6s
    Click element    xpath=//*[@id="webide"]/main/section/form/section[2]/header/div/button[2]/i    # click on Add
    Sleep    6s
    Capture Page screenshot
    Select From list by value    xpath=//*[@id="webide"]/main/section/form/section[2]/article/div[1]/select    2365    #Select the process from dropdown
    Sleep    6s
    Execute Javascript    _editor = document.querySelectorAll("div.CodeMirror")[0].CodeMirror;    _editor.setValue("Setting payload")
    Input Text    name=hours    8    #Set the time
    Click element    xpath=//*[@id="webide"]/main/section/form/section[2]/header/div/button[1]/i    #click save
    Sleep    6s
    Capture page screenshot
    click element    class=fa-refresh    # click refresh
    sleep    6s
    close browser

TC21-Alerts_FilterByInfo
    [Documentation]    Check user can filter Alerts by Info
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
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

TC22-Alerts_FilterByAssignedTo
    [Documentation]    Check user can filter Alerts by Assigned To
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i    #Select Organization
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]    #Select service
    Click Element    class=fa-bell    # Click on Alerts
    Sleep    6s
    capture page screenshot
    Select from List by value    name=filterAssignedUserId    928    # Select the Assigned to person from dropdown
    Sleep    7s
    Click element    xpath=//*[@id="webide"]/main/section/section/header/form/div[4]/button/i
    Sleep    6s
    Click element    xpath=//*[@id="webide"]/main/section/section/section/section[1]/section[1]/article/ul/li[2]
    Sleep    6s
    Capture page Screenshot
    Page should not contain    text=No alerts found

TC23_delete_schedule
    [Documentation]    Check user can remove Schedule
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]
    Click Element    class=fa-calendar
    Sleep    6s
    capture page screenshot
    click element    xpath=//*[@id="webide"]/main/section/form/section[2]/header/button/i
    Sleep    6s
    click element    xpath=//*[@id="webide"]/main/section/form/section[2]/header/div/button[1]/i
    sleep    6s
    click element    class=fa-refresh
    sleep    6s
    Capture page Screenshot

TC24-Logs-FilterById
    [Documentation]    Check user can filter Logs by ID
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]
    Click Element    class=fa-info-circle
    Sleep    6s
    capture page screenshot
    Input text    name=filterIdGte    34348330
    Sleep    7s
    Capture page Screenshot
    Page should contain    text=error
    close browser

TC25-Logs-information
    [Documentation]    Check user can Filter Logs by information
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
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
    close browser

TC26-UsersPage-Search
    [Documentation]    Check user can search user on Users page
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]
    Click Element    class=fa-users
    Sleep    6s
    capture page screenshot
    Input text    name=filter    sami
    Sleep    7s
    Capture page Screenshot
    Page should not contain    text=Mike Flavell
    Page should contain    text=sami
    close browser

TC27-Home
    [Documentation]    Check user can mark organization as Favorite and see those that marked as Favorites on Favorites page
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    capture page screenshot
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[2]/div/p/i
    capture page screenshot
    Click element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[1]/p/a[1]/i
    sleep    6s
    capture page screenshot
    Click element    xpath=//*[@id="webide"]/main/section/section/section/header[1]/div/button/i
    Sleep    6s
    Capture Page Screenshot
    Click element    xpath=//*[@id="webide"]/main/section/section/section/header[1]/div/button/i
    sleep    6s
    capture page screenshot
    Page should contain    text=TestOrganisation1
    Click element    xpath=//*[@id="webide"]/main/section/section/div/div[2]/div/p/i
    Capture page screenshot

TC28-Logout
    [Documentation]    Check user can logout from the application
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
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

TC29_ChangeEndpointType
    [Documentation]    Check user can edit endpoint type if it Binding is not associated to it
    ...
    ...    Komal Test Organisation - Demo Service 3
    ...    Endpoint -1Updated with type Inbound and no binding attached to it
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[3]/div/p/a[2]
    sleep    6s
    Click Element    xpath=//*[@id="webide"]/aside/div[1]/ul/li[7]/a/i
    Sleep    9s
    Capture Page screenshot
    click element    xpath=//*[@id="webide"]/main/section/section/section/header/button[2]/i
    Sleep    6s
    Select from List by Value    xpath=//*[@id="webide"]/main/section/section/form/article/div/div[2]/select    4
    sleep    6s
    Click element    xpath=//*[@id="webide"]/main/section/section/form/header/button/i
    Sleep    6s
    Click element    xpath=//*[@id="webide"]/main/section/section/section/header/button[2]
    Capture page screenshot

TC30_ChangeEndpointType_Negative
    [Documentation]    Check user cannot edit endpoint type if it Binding is associated to it
    ...
    ...    Test Data setup
    ...    Komal Test Organisation - DemoService4
    ...    EndpointB1 with Binding
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Click element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[4]/div[1]/p/a[2]
    sleep    6s
    Click element    xpath=//*[@id="webide"]/aside/div[1]/ul/li[7]/a/i
    Sleep    9s
    Select from list by value    xpath=//*[@id="webide"]/main/section/section/form/article/div/div[2]/select    1
    sleep    6s
    Click element    xpath=//*[@id="webide"]/main/section/section/form/header/button/i
    sleep    6s
    Capture page screenshot
    Page should contain    text=Can't change type of an endpoint that has endpoint bindings
    Capture page screenshot

TC31_AddandDeleteBinding
    [Documentation]    Check user can add Bindings to endpoint and also user can delete bindings
    ...
    ...    Komal test Organisation - Demo service 6
    ...    Counters endpoint
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Click element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[5]/div[1]/p/a[2]
    sleep    6s
    click element    xpath=//*[@id="webide"]/aside/div[1]/ul/li[7]/a/i
    Click element    xpath=//*[@id="webide"]/main/section/section/div/section/header/button[1]/i
    Sleep    6s
    Click element    xpath=//*[@id="webide"]/main/section/section/div/section/header/button[1]/i
    Sleep    6s
    click element    xpath=//*[@id="webide"]/main/section/section/div/section/header/button[1]/i
    sleep    6s
    Input Text    name=OperationName    Binding
    Input Text    name=HTTPMethod    GET
    click element    xpath=//*[@id="webide"]/main/section/section/div/form/header/button/i
    sleep    6s
    capture page screenshot
    Element should be enabled    xpath=//*[@id="webide"]/main/section/section/div/form/header/div/button/i
    Click element    xpath=//*[@id="webide"]/main/section/section/div/form/header/div/button/i
    sleep    6s
    click element    xpath=//*[@id="webide"]/div[5]/form/div/div[3]/span/button[1]/i
    sleep    6s
    click element    xpath=//*[@id="webide"]/main/section/section/div/section/header/button[2]/i
    sleep    6s

TC32_ChangeEndpointName
    [Documentation]    Check user can edit Endpoint name
    ...
    ...    Komal test organisation - DemoService3
    ...    Endpoint name - 1Updated
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[3]/div/p/a[2]
    sleep    6s
    Click Element    xpath=//*[@id="webide"]/aside/div[1]/ul/li[7]/a/i
    Sleep    6s
    Capture Page screenshot
    click element    xpath=//*[@id="webide"]/main/section/section/section/header/button[2]/i
    Sleep    6s
    Input text    name=Description    2Updated
    sleep    6s
    Click element    xpath=//*[@id="webide"]/main/section/section/form/header/button/i
    Sleep    6s
    Click element    xpath=//*[@id="webide"]/main/section/section/section/header/button[2]
    Capture page screenshot
    Page should not contain    text=1EP

TC33_EditOrganisationName
    [Documentation]    Check user can edit Organisation name
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    6s
    click element    xpath=//*[@id="webide"]/main/section/section/div/div[2]/div[1]/p/a[2]
    Sleep    6s
    Click element    xpath=//*[@id="webide"]/aside/div[1]/ul/li[1]/span[2]/a/i
    Input text    name=OrganizationName    UpdatedOrg
    Click element    xpath=//*[@id="webide"]/main/section/section/form/header/button[1]/i
    Sleep    6s
    Click element    xpath=//*[@id="btn-home"]/i
    Scroll element into View    xpath=//*[@id="webide"]/main/section/section/div/div[5]/p/a
    Capture page screenshot
    Page should not contain    text=TestOrg

TC34_AddUserToOrganization
    [Documentation]    Check we can add User to Organisation
    ...
    ...    Test data setup
    ...    Komal test organisation
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
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

TC36_EditUserRoleInOrganization
    [Documentation]    Check that we can add role for the user for organisation
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
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

TC35_DeleteUserFromOrganization
    [Documentation]    check that we can delete user from organisation
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
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

TC37_EditServiceName
    [Documentation]    Check user can edit Service name
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    6s
    click element    xpath=//*[@id="webide"]/main/section/section/div/div[2]/div[1]/p/a[2]
    Sleep    6s
    Capture page screenshot
    Click element    xpath=//*[@id="webide"]/main/section/section/div/div[2]/div/p/a[1]/i
    Sleep    6s
    Click element    xpath=//*[@id="webide"]/main/section/section/div/div[2]/div[2]/div[2]/div/p/a[2]
    Sleep    6s
    Click element    xpath=//*[@id="webide"]/aside/div[1]/ul/li[4]/span[2]/a/i
    Sleep    6s
    Input Text    name=ShortDescription    ServiceUpdated
    sleep    6s
    Click element    xpath=//*[@id="webide"]/main/section/section/form/header/button[1]/i
    Sleep    6s
    Capture page screenshot

TC038_Transfer_FilterbyDuration
    [Documentation]    Check that user can filter transactions by Duration id
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    click element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[1]/p/a[2]
    sleep    6s
    click element    xpath=//*[@id="webide"]/aside/div[1]/ul/li[2]/div/a/i
    sleep    6s
    Input text    xpath=/html/body/main/section/header/form/div[1]/div[4]/div[1]/div/input    3s
    sleep    6s
    click element    xpath=/html/body/main/section/header/form/div[2]/div[4]/div/button[2]/i
    click element    xpath=/html/body/main/section/header/form/div[2]/div[4]/div/button[1]/i
    sleep    9s
    capture page screenshot
    Page should not contain    text=42725968

TC039_Transfer_FilterById
    [Documentation]    Check that user can filter transactions by Duration id
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    click element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[1]/p/a[2]
    sleep    6s
    click element    xpath=//*[@id="webide"]/aside/div[1]/ul/li[2]/div/a/i
    sleep    6s
    Input text    xpath=/html/body/main/section/header/form/div[1]/div[5]/div[1]/div/input    42738865
    sleep    6s
    click element    xpath=/html/body/main/section/header/form/div[2]/div[4]/div/button[2]/i
    click element    xpath=/html/body/main/section/header/form/div[2]/div[4]/div/button[1]/i
    sleep    6s
    capture page screenshot
    Page should not contain    text=42738864

TC39_AddUser
    [Documentation]    Check that If Process does not exist , it should get added successfully
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click element    xpath=//*[@id="webide"]/aside/div[1]/ul/li[9]/a/i
    sleep    6s
    Click element    xpath=//*[@id="webide"]/main/section/section/div/header/button[1]/i
    Input text    xpath=/html/body/main/section/section/section/form/article/div[1]/div[1]/input    tester@youredi.com
    Sleep    6s
    Input Text    xpath=/html/body/main/section/section/section/form/article/div[1]/div[2]/input    1356898
    Sleep    6s
    Input Text    xpath=/html/body/main/section/section/section/form/article/div[2]/div[1]/input    R

TC40_SearchUser
    [Documentation]    Check that If Process does not exist , it should get added successfully
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click element    xpath=//*[@id="webide"]/aside/div[1]/ul/li[9]/a/i
    sleep    6s
    Input Text    name=filter    komal
    Sleep    6s
    Capture page screenshot
    Page should not contain    text=mike

TC41_Transfer_BugTesting
    [Documentation]    Check that Transfer- Duration filter should retain value when we read transfer message log and navigate back to Transfer
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    click element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[1]/p/a[2]
    sleep    6s
    click element    xpath=//*[@id="webide"]/aside/div[1]/ul/li[2]/div/a/i
    sleep    6s
    Input text    xpath=/html/body/main/section/header/form/div[1]/div[4]/div[1]/div/input    3s
    sleep    6s
    click element    xpath=/html/body/main/section/header/form/div[2]/div[4]/div/button[2]/i
    click element    xpath=/html/body/main/section/header/form/div[2]/div[4]/div/button[1]/i
    sleep    6s
    capture page screenshot
    Page should not contain    32354479
    sleep    6s
    Click element    xpath=/html/body/main/section/div/section/div/div/div[1]/div[1]/i
    Sleep    6s
    Click element    xpath=/html/body/main/section/section/header/div[1]/div/button/i
    Sleep    6s
    ${duration}    Get Value    xpath=/html/body/main/section/header/form/div[1]/div[4]/div[1]/div/input
    Should be equal as strings    ${duration}    3s

TC42_EmptyProperty
    [Documentation]    Check that if message property is set \ with empty value , still it should be displayed in Transfer messages
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[1]/div/p/a[1]/i
    sleep    6s
    Click element    xpath=//*[@id="webide"]/main/section/section/div/div[1]/div[2]/div[2]/div[1]/p/a[1]/i
    Sleep    6s
    Click element    xpath=/html/body/main/section/section/div/div[1]/div[2]/div[2]/div[2]/p[2]/a
    Sleep    7s
    Click element    xpath=//*[@id="webide"]/main/section/header/div/button/i
    sleep    6s
    click element    xpath=//*[@id="webide"]/main/section/div[1]/div/div[1]/div/button[1]/i
    sleep    6s
    click element    xpath=//*[@id="webide"]/aside/div[1]/ul/li[2]/div/a/i
    Sleep    6s
    click element    xpath=/html/body/main/section/div/section/div/div/div[1]/div[1]/i
    sleep    6s
    click element    xpath=/html/body/main/section/section/section/article/ul/li[3]/div/div[1]/h6/i
    sleep    6s
    Page should not contain    text=TestEmpytyProperty
    sleep    6s
    click element    xpath=/html/body/main/section/section/section/article/ul/li[4]/div/div[1]/h6/i
    sleep    6s
    Page should contain    text=ANotherScenario

TC43_Extension_Used_In_Process
    [Documentation]    Check that if Extension is being used in any process, then it cannot be deleted
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=/html/body/main/section[1]/section/div/div[1]/div[2]/div[2]/div[1]/p/a[2]
    sleep    6s
    Click element    xpath=//*[@id="webide"]/main/section[2]/section/div/div[1]/div[2]/div[5]/div[1]/p/a[2]
    sleep    6s
    click element    xpath=//*[@id="webide"]/aside/div[1]/ul/li[5]/a/i
    sleep    6s

TC44_ServiceDataPage_Index2NotMandatory
    [Documentation]    Check that index2 is not mandatory on Service data page
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
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
    Page should contain    text=Data

TC45_Portal option should not be present on Old UI
    [Documentation]    Check that portal option should not be present on Old Ui
    Open Browser    https://oldui-stage.youredi.com/Login.aspx    chrome
    Input Text    xpath=//*[@id="MainContentPlaceHolder_TextBoxEmail"]    komal@youredi.com
    Input Password    xpath=//*[@id="MainContentPlaceHolder_TextBoxPassword"]    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    xpath=//*[@id="MainContentPlaceHolder_ButtonLogin"]
    Sleep    6s
    Page should not contain    text=Portals
    Capture Page screenshot

TC46_Body parameter not present
    [Documentation]    Check that when we start the process, Body should not be present in Request if the process has GET Binding
    ...
    ...    Test Data setup
    ...    Demo service 8
    ...    HTTP Get process with Get endpoint binding
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    8s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click element    xpath=/html/body/main/section/section/div/div[1]/div[2]/div[7]/div[1]/p/a[2]
    click element    class=fa-object-group
    sleep    6s
    click element    xpath=/html/body/main/section/section/article/table/tbody/tr/td[2]/a
    sleep    6s
    click element    class=fa-play
    sleep    8s
    Select Frame    xpath=/html/body/main/section[5]/div[1]/div[1]
    Sleep    6s
    Current frame should not contain    text=Body

TC47_Process name Space Trim
    [Documentation]    Check that if message property is set \ with empty value , still it should be displayed in Transfer messages
    ...
    ...    test data setup
    ...    Process - 1Space trim Test should be present
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=/html/body/main/section/section/div/div[1]/div[2]/div[6]/div/p/a[2]
    sleep    6s
    Click element    class=fa-object-group
    Sleep    9s
    Click element    xpath=//*[@id="webide"]/main/section/section/article/table/tbody/tr[1]/td[9]/div/button/i
    Sleep    7s
    Capture page screenshot
    Input Text    xpath=/html/body/div[4]/form/div/div[2]/p[2]/input    1Space trim Test
    sleep    6s
    Click element    xpath=//*[@id="webide"]/div[4]/form/div/div[3]/span/button[1]/i
    sleep    6s
    Capturepage screenshot
    Page should not contain    text=1Space trim Test

TC48_Process Name display on Service Log
    [Documentation]    Check that if message property is set \ with empty value , still it should be displayed in Transfer messages
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=/html/body/main/section/section/div/div[1]/div[2]/div[8]/div[1]/p/a[2]
    Click element    class=fa-object-group
    Sleep    6s
    Click element    xpath=/html/body/main/section/section/article/table/tbody/tr[1]/td[2]/a
    Sleep    7s
    Capture page screenshot
    Click element    xpath=//*[@id="webide"]/main/section/header/div/button/i
    sleep    6s
    Click element    xpath=//*[@id="webide"]/main/section/div[1]/div/div[1]/div/button[1]/i
    sleep    6s
    click element    class=fa-info-circle
    Sleep    6s
    Page should not contain    text=2NewTest

TC49_Subbranch in subprocess of rippe process should get executed
    [Documentation]    Check that steps after end transfer step should not be executed in RIPEE Process
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=/html/body/main/section[1]/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]
    Click element    class=fa-object-group
    Sleep    9s
    click element    xpath=/html/body/main/section[1]/section/article/table/tbody/tr[38]/td[2]/a
    sleep    6s
    click element    class=fa-play
    sleep    6s
    click element    xpath=//*[@id="webide"]/main/section[1]/div[1]/div[1]/div[1]/div/button[1]/i
    Sleep    6s
    click element    xpath=//*[@id="webide"]/aside/div[1]/ul/li[8]/a/i
    sleep    6s
    Page should not contain    text=EndTransfer

TC50_Bug 8771_Test End Transfer step for RIPEE process
    [Documentation]    Bug 8771_Test End Transfer step for RIPEE process
    ...
    ...    Check that no step after end transfer step should get executed
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=/html/body/main/section[1]/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]
    Click element    class=fa-object-group    # click on Processes
    Sleep    9s
    click element    xpath=/html/body/main/section[1]/section/article/table/tbody/tr[39]/td[2]/a    #select RIPEE ET Test
    sleep    6s
    click element    class=fa-play    # Click Start
    sleep    6s
    click element    xpath=//*[@id="webide"]/main/section[1]/div[1]/div[1]/div[1]/div/button[1]/i    # Click Start
    Sleep    6s
    click element    xpath=//*[@id="webide"]/aside/div[1]/ul/li[8]/a/i    # Click Parameters
    sleep    6s
    Page should not contain    text=ET1    #Check that parameter ET1 should not be present
    Close browser

TC51_Check If binding is not active process should not get executed
    [Documentation]    Check if the endpoint binding is not active, process should not get executed.An error message should be displayed
    ...
    ...
    ...    Test Data Setup
    ...    1. Need Organization Name : Komal test organistaion
    ...    2. Need Service -- DemoService
    ...    3 Process name binding whose endpoint binding is not marked active
    Open Browser    https://stage.youredi.com/    chrome
    Input Text    id=email    komal@youredi.com
    Input Password    id=password    $RJvT&Zd*Zzx0tW&R3r32$Pw
    Click Element    class=fa-sign-in
    Sleep    6s
    Click element    xpath= //*[@id="webide"]/main/section/section/div/div[1]/div/p/a[1]/i
    Sleep    7s
    Click Element    xpath=/html/body/main/section[1]/section/div/div[1]/div[2]/div[1]/div[1]/p/a[2]    #Select service
    Click element    class=fa-object-group    #Click on Processes
    Sleep    9s
    click element    xpath=//*[@id="webide"]/main/section/section/article/table/tbody/tr[7]/td[2]/a    #Select Binding process
    Sleep    6s
    click element    xpath=//*[@id="webide"]/main/section[1]/header/div/button/i    #click start
    sleep    6s
    click element    xpath=//*[@id="webide"]/main/section[1]/div[1]/div[1]/div[1]/div/button[1]/i    #click start
    sleep    9s
    Page should contain    text=Process not found using given account    #error message shouldbe present
    capture page screenshot
