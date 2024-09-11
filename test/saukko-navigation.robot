*** Settings ***
Library         SeleniumLibrary
Library         OperatingSystem
Library         Collections
Library         DateTime
Resource        saukko-variables.robot
Resource        saukko-keywords.robot

*** Keywords ***
Go To FrontPage
    [Tags]  navigate  valid
    Open Hamburgermenu
    Wait Until Element Is Visible   xpath=//p[contains(@class,'NavText') and contains(text(),'Etusivu')]
    Click Element                   xpath=//p[contains(@class,'NavText') and contains(text(),'Etusivu')]
    Location Should Be              ${url}


Go To Loginpage
    [Tags]  navigate  valid
    Go To                          ${url}
    Wait Until Element Is Visible  xpath=//section[@class="landingPage__buttons"]//div[@class="button__text" and text()="Kirjaudu sisään"]   5
    Scroll Element Into View       xpath=//section[@class="landingPage__buttons"]//div[@class="button__text" and text()="Kirjaudu sisään"]
    Click Element                  xpath=//section[@class="landingPage__buttons"]//div[@class="button__text" and text()="Kirjaudu sisään"]
    Location Should Be             ${url}login


Go To Degreespage
    [Tags]  navigate  valid
    Go To              ${url}
    Open Hamburgermenu
    Wait Until Element Is Visible   xpath=//p[contains(@class,'NavText') and contains(text(),'Tutkinnot')]  5
    Click Element                   xpath=//p[contains(@class,'NavText') and contains(text(),'Tutkinnot')]
    Wait Until Location Is          ${url}degrees/add  5


Go To Profilepage
    [Tags]  navigate  valid
    Go To                          ${url}
    Open Hamburgermenu
    Wait Until Element Is Visible  xpath=//p[contains(@class,'NavText') and contains(text(),'Profiili')]  5
    Click Element                  xpath=//p[contains(@class,'NavText') and contains(text(),'Profiili')]
    Wait Until Location Is         ${url}profile  5


Go To Jobpage
    [Tags]  navigate  valid
    Open Hamburgermenu
    Wait Until Element Is Visible    xpath=//p[contains(@class,'NavText') and contains(text(),'Työpaikat')]  5
    Click Element                    xpath=//p[contains(@class,'NavText') and contains(text(),'Työpaikat')]
    Wait Until Location Is           ${url}add/companyname  5


Go To Contractpage
    [Tags]  navigate  valid
    Open Hamburgermenu
    Wait Until Element Is Visible    xpath=//p[contains(@class,'NavText') and contains(text(),'Luo uusi sopimus')]  5
    Click Element                    xpath=//p[contains(@class,'NavText') and contains(text(),'Luo uusi sopimus')]
    Wait Until Location Is           ${url}evaluation-form  5


Go To Frontpage From Contractpage
    [Tags]  navigate  valid
    Open Hamburgermenu
	Page Should Contain             Varoitus
	Page Should Contain             Jos poistut sivulta, tallentamattomat tiedot menetetään.
    Click Button                    xpath=/html/body/div[2]/div[3]/div/div[2]/button[2]
    Wait Until Element Is Visible   xpath=//p[contains(@class,'NavText') and contains(text(),'Etusivu')]
    Click Element                   xpath=//p[contains(@class,'NavText') and contains(text(),'Etusivu')]
