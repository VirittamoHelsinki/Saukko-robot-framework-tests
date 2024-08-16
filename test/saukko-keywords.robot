*** Settings ***
Library         SeleniumLibrary
Library         OperatingSystem
Library         Collections
Library         DateTime
Resource        saukko-variables.robot


*** Keywords ***
# OK
Open Browserwindow
    # # reduced speed for debugging, comment out for speedrun
    Set Selenium Speed          0.2

    Open Browser                ${url}    ${browser}
    Sleep                       5  # enough time to press the default search-engine popup in chrome
    Set Browser Implicit Wait   2 seconds


# OK
Generate Random Workplace
    ${current_time}=     Evaluate   time.time()  time
    Evaluate             random.seed(${current_time})  random
    ${word}=             Evaluate   random.choice(@{r_words})  random
	${location}=         Evaluate   random.choice(@{r_locations})   random
    ${business}=         Evaluate   random.choice(@{r_business})    random
    ${workplace}=        Set Variable  ${word}${location} ${business}
    Return From Keyword  ${workplace}


# OK
Generate Random Vatnumber
    ${current_time}=      Evaluate   time.time()  time
    Evaluate              random.seed(${current_time})  random
    ${first}=             Evaluate  random.randint(1, 9)  random
    ${digits}=            Evaluate   ''.join(random.choices('0123456789', k=6))   random
    ${last}=              Evaluate  random.randint(1, 9)   random
    ${vat}=               Set Variable   ${first}${digits}-${last}
    Return From Keyword   ${vat}


# OK
Go To Loginpage
    [Tags]  navigate  valid
    Go To                          ${url}
    Wait Until Element Is Visible  xpath=//section[@class="landingPage__buttons"]//div[@class="button__text" and text()="Kirjaudu sisään"]   2
    Scroll Element Into View       xpath=//section[@class="landingPage__buttons"]//div[@class="button__text" and text()="Kirjaudu sisään"]
    Click Element                  xpath=//section[@class="landingPage__buttons"]//div[@class="button__text" and text()="Kirjaudu sisään"]
    Location Should Be             ${url}login

# OK
Go To Degreespage
    [Tags]  navigate  valid
    Go To              ${url}
    Open Hamburgermenu
    Wait Until Element Is Visible   xpath=//p[contains(@class,'NavText') and contains(text(),'Tutkinnot')]
    Click Element                   xpath=//p[contains(@class,'NavText') and contains(text(),'Tutkinnot')]
    Wait Until Location Is Not      ${url}    2
    Location Should Be              ${url}degrees/add

# OK
Go To Profilepage
    [Tags]  navigate  valid
    Go To                          ${url}
    Open Hamburgermenu
    Wait Until Element Is Visible  xpath=//p[contains(@class,'NavText') and contains(text(),'Profiili')]
    Click Element                  xpath=//p[contains(@class,'NavText') and contains(text(),'Profiili')]
    Wait Until Location Is Not     ${url}  2
    Location Should Be             ${url}profile

# OK
Toggle Password Visibility
    [Tags]  button  valid
    Click Element    xpath=//*[@id="root"]/div/div/div[2]/main/div/section/div[3]/form/div/div/div[2]/div[1]/div/span
    Click Element    xpath=//*[@id="root"]/div/div/div[2]/main/div/section/div[3]/form/div/div/div[2]/div[2]/div/span
    Click Element    xpath=//*[@id="root"]/div/div/div[2]/main/div/section/div[3]/form/div/div/div[2]/div[3]/div/span

# OK
Change Password
    [Tags]  password  valid
    [Arguments]  ${old_pw}  ${new_pw}
    Go To Profilepage
    Wait Until Element Is Visible   xpath=//*[@id="root"]/div/div/div[2]/main/div/section/div[3]
    Click Element                   xpath=//*[@id="root"]/div/div/div[2]/main/div/section/div[3]
    Toggle Password Visibility
    Input Password                  xpath=//*[@id="root"]/div/div/div[2]/main/div/section/div[3]/form/div/div/div[2]/div[1]/div/input  ${old_pw}
    Input Password                  xpath=//*[@id="root"]/div/div/div[2]/main/div/section/div[3]/form/div/div/div[2]/div[2]/div/input  ${new_pw}
    Input Password                  xpath=//*[@id="root"]/div/div/div[2]/main/div/section/div[3]/form/div/div/div[2]/div[3]/div/input  ${new_pw}
    Toggle Password Visibility
    Click Button                    xpath=//*[@id="root"]/div/div/div[2]/main/div/section/div[3]/form/div/div/button
    Page Should Contain             Tiedot päivitetty
    Click Button                    xpath=//*[@id="customized-dialog-title"]/button

# OK
Enter Login Credentials
    [Tags]  login  valid
    [Arguments]  ${email}  ${password}  ${firstname}
    Location Should Be          ${url}login
    Input Text                  id:email     ${email}
    Input Password              id:password  ${password}
    Click Element               xpath=//div[@class="button__text" and text()="Kirjaudu sisään"]
    Wait Until Location Is Not  ${url}login  3
    Location Should Be          ${url}
    Page Should Contain         Tervetuloa ${firstname}

# OK
Open Hamburgermenu
    [Tags]  valid  menu
    Wait Until Element Is Visible   xpath=//*[@id="root"]/div/div/div[2]/header/div[1]/button      3
    Wait Until Page Contains        Kirjaudu ulos
    Click Element                   xpath=//*[@id="root"]/div/div/div[2]/header/div[1]/button

# OK
Login User
    [Tags]  login  navigate  valid
    [Arguments]  ${email}  ${password}  ${firstname}
    Go To Loginpage
    Enter Login Credentials  ${email}  ${password}  ${firstname}

# OK
Logout User
    [Tags]  logout  valid
    Open Hamburgermenu
    Wait Until Element Is Visible   xpath=//*[@id="root"]/div/div/div[1]/div[2]/div[3]/div/button  2
    Click Button                    xpath=//*[@id="root"]/div/div/div[1]/div[2]/div[3]/div/button
    Page Should Contain Button      xpath=//*[@id="root"]/div/div/div[2]/main/div/section[2]/button
    Page Should Contain             Kirjaudu sisään


# OK
Forgotten Password Case
    [Tags]  valid  email  navigate
    [Arguments]  ${email}
    Go To Loginpage
    Click Link                  css:a[href="/forgot-password"]
    Wait Until Location Is      ${url}forgot-password  2
    Input Text                  id:email    ${email}
    Click Element               xpath=//div[@class="button__text" and text()="Lähetä"]
    Page Should Contain         Tarkista sähköpostisi
    Wait Until Location Is Not  ${url}forgot-password  6


# OK
Forgotten Password Invalid Email
    [Tags]  invalid  email  navigate
    [Arguments]  ${email}
    Go To Loginpage
    Click Link                  css:a[href="/forgot-password"]
    Wait Until Location Is      ${url}forgot-password  2
    Input Text                  id:email    ${email}
    Click Element               xpath=//div[@class="button__text" and text()="Lähetä"]
    Page Should Not Contain     Tarkista sähköpostisi
    Location Should Be          ${url}forgot-password



#    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #
#    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #
#    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #
#    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #
#    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #





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


   # Press Keys    None  CTRL+SHIFT+M
   # Press Keys  None   F12
   # Open Context Menu    xpath=//div[@id="root"]
   Wait Until Element Is Visible    xpath=//section[@class="landingPage__buttons"]//div[@class="button__text" and text()="Kirjaudu sisään"]
   Scroll Element Into View    xpath=//section[@class="landingPage__buttons"]//div[@class="button__text" and text()="Kirjaudu sisään"]
   Double Click Element     xpath=//section[@class="landingPage__buttons"]//div[@class="button__text" and text()="Kirjaudu sisään"]



# Forgotten password case
#     # In case of user forget own password can go this process to ask new password via e-mail
#     # Click Element     //*[contans(text(), "Unohtutko salasana?")]
#     # Click Element    id:forgot-password-link
#     Click Link    css:a[href="/forgot-password"]
#     Click Element    id:email
#     Clear Element Text    id:email
#     Input Text    id:email    shahroz@test.fi
#     Click Element    xpath=//div[@class="button__text" and text()="Lähetä"]

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