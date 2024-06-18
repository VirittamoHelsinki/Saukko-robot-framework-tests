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
Login as teacher
    [Documentation]
    ...   Test description:
    ...       Cheks log in process as teacher to be sure all process is working well
    ...   Test proceeding:
    ...       In this part we will login with teacher e-mail and password. 
    ...       Before inputing text, its better first to click on text place by click element and clear texts inside wich could be there.
    ...       In our case it is no default text inside boxes and because of that I disabled those 2 lines.
    ...       Same process continuse for password writing and finally click to login button to log in the page. 
    ...   Expected output / acceptance criteria:
    ...       E-mail and password with teacher role can log in succusfully. 
    
    # Login as teacher with username and password
    # Click Element    id:email
    # Clear Element Text    id:email
    Input Text    id:email    ${teacher.e-mail}

    # Click Element    id:password
    # Clear Element Text    id:password
    Input Password    id:password    ${teacher.password}

    # Show written password
    # Click Element    id:password-toggle

    # Click on login button
    Click Element    xpath=//div[@class="button__text" and text()="Kirjaudu sisään"]

    # The page load take time. Because of that gave time to wait untill the page loaded
    Wait Until Element Is Visible   xpath=//div[@class="${hamburger-menu}"]    ${time}
    
Logout as teacher
    # Click on icon on right down corner to go to profile page and click logout
    Click Element    xpath=//div[@class="${hamburger-menu}"]
    Click Element    xpath=//p[contains(@class,'MuiTypography-root MuiTypography-body1 css-yxssz') and contains(text(),'Kirjaudu ulos')]


Degree Management pages as teacher
# Tutkintujen Hallinta
    [Documentation]
    ...   Test description:
    ...        In this part adding degree as teacher
    ...    Test proceeding:
    ...         Here via hamburger menu going to the degree management page. 
    ...        Select hamburger menu and then click on tutkinnot from the opened Menu
    ...        By clicking on "Lisää tutkinto" could go forward to adding degree
    ...        By clicking on search bar we could some degree nama. in our case we search ajoneuvolan perustutkinto by clicking only 3 first letter -
    ...        - wich are "ajo" and selecting first result.
    ...        In the next page we test edit button to check if it is work in right way or not.
    ...        Click edit and finish edit (we didn't test edit part yet. in case of need we could add)
    ...        Going to the next page by clicking "Seuraava" button
    ...        Remember to add Scroll to Bottom to display buttons in down page 
    ...        Click on chekboxes. Have to next pages to be sure that it works.
    ...    Expected output / acceptance criteria:
    ...        We could go forward all process and could add new degree

    # Click icon to go to Hallinnointi page
    Click Element    xpath=//div[@class="${hamburger-menu}"]

    # Click to Tutkintojen hallinta
    Click Element    xpath=//p[contains(@class,'MuiTypography-root') and contains(text(),'Tutkinnot')]

    # Click on Lisää tutkinto
    Click Element    xpath=//div[@class="button__text"]
    Sleep    4seconds
    Click Element    xpath=//h3[text()="Ajoneuvoalan perustutkinto"]
    Scroll To Bottom
    Click Element    xpath=//div[@class="buttons__container-forward"]//div[@class="button__text" and text()="Seuraava"]

    # Click two options from list. Here choose first and third option
    Click Element    xpath=//div[@class="degreeUnits__container--units"]/div[@class="selectUnit__container--units-unit false"][1]
    Click Element    xpath=//div[@class="degreeUnits__container--units"]/div[@class="selectUnit__container--units-unit false"][2]
    
    Scroll To Bottom
    Click Element    xpath=//div[@class="buttons__container-forward"]//div[@class="button__text" and text()="Seuraava"]
    
    # Edit information and finish editing
    Click Button    id:finishEditButton
    Click Button    id:finishEditButton
    Click Element    xpath=//div[@class="buttons__container-forward"]//div[@class="button__text" and text()="Seuraava"]

    # In page 3 adding criteeria (Lisää ammattitaitovaatimukset)
    Click Element    id:addCriteriaButton

    Click Element    id:outlined-multiline-static
    Input Text    id:outlined-multiline-static    ATV1-name

    Click Element    xpath://textarea[@rows="8"]
    Input Text    xpath://textarea[@rows="8"]    ATV1-Criteria

    Click Element    xpath=//button[contains(text(), 'Tallenna')]

    # going to next degree to add criteeria
    
    # goes to next one
    Click Element    id:nextButton

    # add new creteria for new degree
    Click Element    id:addCriteriaButton

    Click Element    id:outlined-multiline-static    # or could add:  Click Element xpath://textarea[not(@rows="8")]
    Input Text    id:outlined-multiline-static    ATV2-name

    Click Element    xpath://textarea[@rows="8"]
    Input Text    xpath://textarea[@rows="8"]    ATV2-Criteria

    Click Element    xpath=//button[contains(text(), 'Tallenna')]

    Click Element    id:addCriteriaButton

    Click Element    id:outlined-multiline-static    # or could add:  Click Element xpath://textarea[not(@rows="8")]
    Input Text    id:outlined-multiline-static    ATV2-second creteria name

    Click Element    xpath://textarea[@rows="8"]
    Input Text    xpath://textarea[@rows="8"]    ATV2-Second Criteria text

    Click Element    xpath=//button[contains(text(), 'Tallenna')]

    # Closed criteria mini page and process continue in main page
    Scroll To Bottom
    Sleep    2
    Click Element    xpath=//div[@class="buttons__container-forward"]//div[@class="button__text" and text()="Vahvista valinnat"]

    Scroll To Bottom
    Scroll Element Into View    id:pageNavigationButtonsContainer

    # If we don't want to save in every test, we have to disabled last line which save whole process. 
    Click Element    xpath=//div[@class="buttons__container-forward"]//div[@class="button__text" and text()="Tallenna tiedot"]

    Click Element    xpath=//*[@id="customized-dialog-title"]/button
    
    # Here we go again to degree management from menu to use some degree and edit it without adding new one

    # Click icon to go to Hallinnointi page
    Click Element    xpath=//div[@class="${hamburger-menu}"]

    # Click to Tutkintojen hallinta
    Click Element    xpath=//p[contains(@class,'MuiTypography-root') and contains(text(),'Tutkinnot')]


    # Click on search bar and input some text. In my case I put ajo and select first result
    Sleep    1s
    # Click Element    xpath=//div[@class="searchField__container"]
    Click Element    xpath=//input[@placeholder="Etsi tutkinto"]
    Input Text    xpath=//input[@placeholder="Etsi tutkinto"]    ajo
    Click Element    xpath=//*[@id="listContainer"]/div/p
    Sleep    6

    # Click pen mark to edit and then X to close mini page
    Click Element    xpath=//div[@class="_circleWrapIcon_124y2_89"]/span
    Click Element    xpath=//div[@class="button__text" and text()="Tallenna"]
    Click Element    xpath=//*[@id="customized-dialog-title"]/button
    Scroll To Bottom
    Click Element    xpath=//div[@class="buttons__container-back"]//div[@class="button__text" and text()="Takaisin"]





Work Place Management as teacher
# Työpaikkojen hallinta 
    [Documentation]
    ...    Test description:
    ...        This process adding work place and supervior linked to it
    ...    Test proceeding:
    ...        Here robot goes step by step forward and starting from work places, goes to add work place information and supervisor information
    ...        In the next step adds degree to this work place witch added.
    ...        In forwarding to next pages by clicking next button on the bottom of page, its add new work place and supervisor to mongoDB
    ...    Expected output / acceptance criteria:
    ...        Work place and supervior linke to it added

    # Click icon to go to Hallinnointi page
    Click Element    xpath=//div[@class="${hamburger-menu}"]

    # Click to Työpaikkojen hallinta
    Click Element    xpath=//p[contains(@class,'MuiTypography-root') and contains(text(),'Työpaikat')]

    # Click on Lisää työpaikka
    Click Element    xpath=//button[@class="button__container "]/div[@class="button__text" and text()="Lisää työpaikka"]

    # Click and Fill form first part
    Click Element    xpath=//p[text()='1. Työpaikka tiedot']
    Sleep    3
    Click Element    id:business-id-input
    Input Text    id:business-id-input    1234567-9

    Click Element    id:company-name-input
    Input Text    id:company-name-input    ShS-workplace
    
    Scroll To Bottom

    # Click and Fill form second part
    Click Element    xpath=//p[text()='2. Työpaikkaohjaajan tiedot']
    Scroll To Bottom
    Click Element    id:first-name-input
    Input Text    id:first-name-input    ${supervisor.name}
    Click Element    id:last-name-input
    Input Text    id:last-name-input    ${supervisor.lastname}
    Click Element    id:email-input
    Input Text    id:email-input    ${supervisor.e-mail}

    Scroll To Bottom
    Sleep    2
    Click Element    xpath=//div[@class="buttons__container-forward"]//div[@class="button__text" and text()="Seuraava"]

    # Click on search bar and input some text. In my case I put "ajo" and select first result
    Click Element    //div[@class="searchField__container"]
    Click Element    //input[@placeholder="Etsi tutkinto"]
    Input Text    //input[@placeholder="Etsi tutkinto"]    ajo

    # Select first result
    Wait Until Element Is Visible    xpath=(//div[contains(@class, 'company__searchPage__container--list-item')])[1]
    Click Element    xpath=(//div[contains(@class, 'company__searchPage__container--list-item')])[1]
    Sleep    6
    Click Element    xpath=//div[@class="degreeUnits__container--units"]//div[@class="selectUnit__container--units-unit-checkbox false"]

    Scroll To Bottom
    Sleep    2
    Click Element    xpath=//div[@class="buttons__container-forward"]//div[@class="button__text" and text()="Seuraava"]

    Scroll To Bottom
    Sleep    2
    Click Element    xpath=//div[@class="buttons__container-forward"]//div[@class="button__text" and text()="Vahvista"]


Degree activation as teacher
# Suorituksen aktivoiminen
    [Documentation]
    ...    Test description:
    ...        Want to activate degree to student. Add student to degree and linking work place with supervisor to him/her
    ...    Test proceeding:
    ...        Firstable we adding student to customer information with starting and ending contract. 
    ...        Then adding work place with supervisor to this degree
    ...        Add sub-parts of degree and go forward. 
    ...        Finally check information and save all to the database
    ...    Expected output / acceptance criteria:
    ...         Added studend with new contract to the system which linked supervisor and workplace

    # Click icon to go to Hallinnointi page
    Click Element    xpath=//div[@class="${hamburger-menu}"]

    # Click to Työpaikkojen hallinta
    Click Element    xpath=//p[contains(@class,'MuiTypography-root') and contains(text(),'+ Luo uusi sopimus')]
    Sleep    3
    
    Click Element    id:firstName
    Input Text    id:firstName    ${customer1.name}

    Click Element    id:lastName
    Input Text    id:lastName    ${customer1.lastname}

    Click Element    id:email
    Input Text    id:email    ${customer1.e-mail}

    Scroll Element Into View    id:workTasks
    Click Element    xpath=(//button[@aria-label='Choose date'])[1]
    Sleep    2
    Click on Calendar Day    1
    # Change Placeholder    class: MuiInputBase-input    01.01.2024

    # In code below button[@aria-label='Choose date'] is second button in page but after choose date for first "aria-label", name changes for it and second one shows as first in page. 
    # In blank form code below shows as button[@aria-label='Choose date'][2] but after fill first calendar, it shows as button[@aria-label='Choose date'][1]
    Click Element    xpath=(//button[@aria-label='Choose date'])[1]

    # Go to next page in opend calendar
    Click Element    xpath=/html/body/div[2]/div[2]/div/div/div/div[1]/div[2]/button[2]
    Sleep    2
    Click on Calendar Day    28
    Sleep    2
    Input Text    id:workTasks    Here some text about work task
    Scroll Element Into View    xpath=//div[@class="buttons__container-forward"]//div[@class="button__text" and text()="Seuraava"]
    Input Text    id:workGoals    Here comes texts under omat tavoitteesi
    Scroll To Bottom
    Sleep    2
    Click Element    xpath=//div[@class="buttons__container-forward"]//div[@class="button__text" and text()="Seuraava"]
    Sleep    2
    Click Element    class:searchField__container
    Input Text    //input[@placeholder="Etsi työpaikka"]    shs
    Scroll Element Into View    xpath=//div[@class="buttons__container-forward"]//div[@class="button__text" and text()="Seuraava"]
    
    # Select ShS-työpaikka from radio button
    Click Element    xpath=//input[@class="PrivateSwitchBase-input css-1m9pwf3"]
    Sleep    2

    # CLick on Valitse to open the valitse menu
    Click Element    xpath=//div[@class="MuiButtonBase-root MuiAccordionSummary-root css-qxw5on"]
    
    # Select ShS-työpaikka then click on "Valitse" and then click Ohjaajan Etunimi and Sukunimi from menu opened
    Wait Until Element Is Visible   //*[@data-testid="ExpandMoreIcon"]
    Sleep   3
    Scroll To Bottom
    ${extended}=   Get Element Attribute   //div[@class="accordion__wrapper-details "]  aria-expanded
    Scroll To Bottom
    # Run Keyword If   "${extended}" == "true"  Click Element   //*[@class="accordion__wrapper-details "]
    # Run Keyword If   "${extended}" == "false"  Run Keywords  Click Element   //*[@id="root"]/main/div/main/section/div[3]/div[2]/div[2]/div/div/div/div/div/div[1]
    # ...   AND   Click Element   //*[@class="accordion__wrapper-details "]
    
    Click Element   //*[@class="accordion__wrapper-details "]
    Sleep    2
    
    # CLick on Valitse to close the valitse menu
    Click Element    xpath=//div[@class="MuiAccordionSummary-content Mui-expanded css-1n11r91"]
    
    Scroll Element Into View    id:pageNavigationButtonsContainer
    Click Element    xpath=//div[@class="buttons__container-forward"]//div[@class="button__text" and text()="Seuraava"]

    # Check mark text box and next button
    Click Element    xpath=//div[@class="selectUnit__container--units-unit-checkbox false"][1]
    Click Element    xpath=//div[@class="buttons__container-forward"]//div[@class="button__text" and text()="Seuraava"]

    # Come to page down part and click on next button
    Scroll To Bottom
    Scroll Element Into View    id:pageNavigationButtonsContainer
    # Click Element    xpath=//div[@class="buttons__container-forward"]//div[@class="button__text" and text()="Tallenna"]
    
    Close Browser

General management page as teacher
    [Documentation]
    ...    Test description:
    ...        This parts goes from first page with teacher role and see all costumers with different processes
    ...    Test proceeding:
    ...        In this part we are going through coustomer name and give our values and grades with feedback as teacher
    ...        Cheks if the color of student process changes afrer all done.
    ...    Expected output / acceptance criteria:
    ...         Could go through different student and make evaluation as teacher. Colors have to change in different processes

    # Click on "Kesken", first name under it and come back
    Wait Until Element Is Visible    xpath=(//div[@class="customerList__accordion"]//p)[1]
    Click Element    xpath=(//div[@class="customerList__accordion"]//p)[1]
    Wait Until Element Is Visible    xpath=//div[@class="unitstatus-wrapper"]    ${time}
    Click Element    xpath=//div[@class="unitstatus-wrapper"]
    
    # Check first radio button and then second radio button
    Click Element    xpath=//*[@name="Opettajan merkintä" and @value="Osaa ohjatusti"]
    Click Element    xpath=//*[@name="Opettajan merkintä" and @value="Osaa itsenäisesti"]
    Scroll To Bottom

    # Click 3 checkboxes
    Click Element    name:suoritusValmis
    Click Element    name:yhteydenottoAsiakkaalta
    Click Element    name:yhteydenottoOhjaajalta

    # Write something as feedback (Palaute), save and go on
    Click Element    xpath=//textarea[@placeholder="Palautuksen yhteydessä voit jättää asiakkaalle ja ohjaajalle tutkinnon-osaan liittyvän viestin."]
    Input Text    xpath=//textarea[@placeholder="Palautuksen yhteydessä voit jättää asiakkaalle ja ohjaajalle tutkinnon-osaan liittyvän viestin."]    Feedback (Palaute) comes here.
    
    Click Element    xpath=//div[@class="button__text" and text()="Tallenna ja Lähetä pyynto"]

    # Close alert by clicking on X mark
    Click Element    css=button[aria-label="close"]

    # Go go etusivu via menu
    Click Element    xpath=//div[@class="_buttonContainer_1bjje_23"]
    Click Element    xpath=//p[contains(@class,'MuiTypography-root') and contains(text(),'Etusivu')]

    Close Browser
    

    