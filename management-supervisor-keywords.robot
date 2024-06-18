*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Library     Collections
Library     DateTime
Resource    saukko-keywords.robot
Resource    management-teacher-keywords.robot
Resource    management-supervisor-keywords.robot
Resource    management-customer-keywords.robot



*** Keywords ***

Login as supervisor
    [Documentation]
    ...   Test description:
    ...        Cheks log in process as supervisor to be sure all process is working well
    ...    Test proceeding:
    ...        In this part we will login with supervior e-mail and password. 
    ...        Before inputing text, its better first to click on text place by click element and clear texts inside wich could be there.
    ...        In our case it is no default text inside boxes and because of that I disabled those 2 lines.
    ...        Same process continuse for password writing and finally click to login button to log in the page. 
    ...    Expected output / acceptance criteria:
    ...        E-mail and password with supervisor role can log in succusfully.

    # Login as supervisor with username and password
    # Click Element    id:email
    # Clear Element Text    id:email
    Input Text    id:email    ${supervisor.e-mail}

    # Click Element    id:password
    # Clear Element Text    id:password
    Input Password    id:password    ${supervisor.password}

    # Show written password
    # Click Element    id:password-toggle

    # Click on login button
    Click Element    xpath=//div[@class="button__text" and text()="Kirjaudu sisään"]

    Wait Until Element Is Visible   xpath=//div[@class="${hamburger-menu}"]    ${time}
       
Logout as supervisor
    # Click on icon on right down corner to go to profile page and click logout
    Click Element    xpath=//div[@class="${hamburger-menu}"]

    # Click Element    //button[contains(.,'Kirjaudu ulos')]

    Click Element    xpath=//p[contains(@class,'MuiTypography-root') and contains(text(),'Profiili')]
    Click Element    xpath=//div[@class="button__text" and text()="Kirjaudu Ulos"]


General management page as supervisor
    [Documentation]
    ...    Test description:
    ...        This parts goes from first page with supervisor role and see all costumers with different processes
    ...    Test proceeding:
    ...        In this part we are going through customer name and give our values and grades with feedback as supervior
    ...        Cheks if the color of student process changes afrer all done.
    ...    Expected output / acceptance criteria:
    ...         Could go through different student and make evaluation as supervior. Colors have to change in different processes
    
    
    # Choose first name. Here we chose based on name which starter with "Meri"
    # ${first_name}    Get Text    xpath=//div[@class="customerList__accordion"]/a[1]
    # Click Element    xpath=//div[@class="customerList__accordion"]/a[contains(text(),'${first_name}')]
    Click Element    xpath=//div[@class="customerList__accordion"]/div[1]
    #Click Element    id:panel1a-content
    Scroll To Bottom
    Click Element    xpath=//div[@class="unitstatus"]

    # Click on both radio buttons
    Click Element    xpath=//*[@name="TPO havainto" and @value="Osaa ohjatusti"]
    Click Element    xpath=//*[@name="TPO havainto" and @value="Osaa itsenäisesti"]
    
    Scroll To Bottom
    
    # Click on chekboxes
    Click Element    name:valmisLahetettavaksi
    Click Element    name:pyydetaanYhteydenottoaOpettajalta

    # Write feed back on text area
    Input Text       xpath=//div[@class="buttons-and-form"][1]//textarea    Palatute or feedback comes here
    Scroll To Bottom

    # Save and send form
    Click Element    xpath=//div[@class="button__text" and text()="Tallenna ja Lähetä"]
    Click Element    xpath=//*[@id="customized-dialog-title"]/button
    
    Logout as supervisor




    