*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Library     Collections
Library     DateTime
Resource    saukko-keywords.robot
Resource    management-teacher-keywords.robot
Resource    management-supervisor-keywords.robot
Resource    management-customer-keywords.robot

*** Variables ***
${url1}      http://localhost:5173/
${url2}      https://saukko-dev-app-cf2pynvwyijf4.azurewebsites.net/
${url3}      https://saukko-prod-app-pppoz4ij7jaqc.azurewebsites.net/

${browser}       chrome
${time}        15

${hamburger-menu}    _buttonContainer_1ndim_25

${teacher.e-mail}    shahroz.saeidi@edu.hel.fi 
${teacher.password}        123456789

${supervisor.name}    Sh-OhjaajanEtunimi
${supervisor.lastname}    Sh-OhjaajanSukunimi
${supervisor.e-mail}    shahroz75+supervisor@gmail.com 
${supervisor.password}        123456789 

${customer1.name}        Sh-name01
${customer1.lastname}    Sh-surname01
${customer1.e-mail}        shahroz75+test01@gmail.com 
${customer1.password}        123456789

${customer2.name}        Sh-name02
${customer2.lastname}    Sh-surname02
${customer2.e-mail}        shahroz75+test02@gmail.com 
${customer1.password}        123456789

${customer3.name}        Sh-name03
${customer3.lastname}    Sh-surname03
${customer3.e-mail}        shahroz75+test03@gmail.com 
${customer1.password}        123456789



*** Keywords ***
First page
    [Documentation]
    ...    Test description:
    ...        This keyword created to access to the first page all the time. We can use keyword as "First page" which open browser with given link
    ...    Test proceeding:
    ...        Here goes to see url and browser type from variables parts and based on that opens link
    ...    Expected output / acceptance criteria:
    ...        Have to open link in described browser

   # Going to very first page and click on login
   Open Browser    ${url2}    ${browser}

   Set Selenium Speed      1seconds
   
   # Press Keys    None  CTRL+SHIFT+M
   # Press Keys  None   F12
   # Open Context Menu    xpath=//div[@id="root"]
   Wait Until Element Is Visible    xpath=//section[@class="landingPage__buttons"]//div[@class="button__text" and text()="Kirjaudu sisään"]
   Scroll Element Into View    xpath=//section[@class="landingPage__buttons"]//div[@class="button__text" and text()="Kirjaudu sisään"]
   Double Click Element     xpath=//section[@class="landingPage__buttons"]//div[@class="button__text" and text()="Kirjaudu sisään"]



Forgotten password case
    # In case of user forget own password can go this process to ask new password via e-mail
    # Click Element     //*[contans(text(), "Unohtutko salasana?")]
    # Click Element    id:forgot-password-link
    Click Link    css:a[href="/forgot-password"]
    Click Element    id:email
    Clear Element Text    id:email
    Input Text    id:email    shahroz@test.fi
    Click Element    xpath=//div[@class="button__text" and text()="Lähetä"]

Scroll To Bottom
    Execute JavaScript  window.scrollTo(0, document.body.scrollHeight);


Click Random Options
    FOR    ${index}    IN RANGE    2
        ${random_index}    Evaluate    random.randint(1, 4)
        Click Element    xpath=(//div[@class="degreeUnits__container--units"]//p)[${random_index}]
    END

Change Placeholder
    [Arguments]    ${locator}    ${text}
    ${element}=    Wait Until Element Is Visible    ${locator}
    Execute JavaScript    arguments[0].setAttribute('placeholder', '${text}')    ${element}
# line below should be in the main body whcih related to placeholder
# Change Placeholder    class: MuiInputBase-input    01.01.2024

Click on Calendar Day
    [Arguments]    ${day}
    ${day_button_xpath}=    Set Variable    //button[@role="gridcell" and contains(text(), "${day}")]
    Click Element    ${day_button_xpath}