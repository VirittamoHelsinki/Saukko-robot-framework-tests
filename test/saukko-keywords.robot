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
    Set Selenium Speed          0.1

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
Go To FrontPage
    Go To Profilepage
    Open Hamburgermenu
    Wait Until Element Is Visible   xpath=//p[contains(@class,'NavText') and contains(text(),'Etusivu')]
    Click Element                   xpath=//p[contains(@class,'NavText') and contains(text(),'Etusivu')]
    Wait Until Location Is Not      ${url}profile  5
    Location Should Be              ${url}


# OK
Go To Loginpage
    [Tags]  navigate  valid
    Go To                          ${url}
    Wait Until Element Is Visible  xpath=//section[@class="landingPage__buttons"]//div[@class="button__text" and text()="Kirjaudu sisään"]   5
    Scroll Element Into View       xpath=//section[@class="landingPage__buttons"]//div[@class="button__text" and text()="Kirjaudu sisään"]
    Click Element                  xpath=//section[@class="landingPage__buttons"]//div[@class="button__text" and text()="Kirjaudu sisään"]
    Location Should Be             ${url}login

# OK
Go To Degreespage
    [Tags]  navigate  valid
    Go To              ${url}
    Open Hamburgermenu
    Wait Until Element Is Visible   xpath=//p[contains(@class,'NavText') and contains(text(),'Tutkinnot')]  5
    Click Element                   xpath=//p[contains(@class,'NavText') and contains(text(),'Tutkinnot')]
    Wait Until Location Is          ${url}degrees/add  5

# OK
Go To Profilepage
    [Tags]  navigate  valid
    Go To                          ${url}
    Open Hamburgermenu
    Wait Until Element Is Visible  xpath=//p[contains(@class,'NavText') and contains(text(),'Profiili')]  5
    Click Element                  xpath=//p[contains(@class,'NavText') and contains(text(),'Profiili')]
    Wait Until Location Is         ${url}profile  5


# OK
Go To Jobpage
    [Tags]  navigate  valid
    Open Hamburgermenu
    Wait Until Element Is Visible    xpath=//p[contains(@class,'NavText') and contains(text(),'Työpaikat')]  5
    Click Element                    xpath=//p[contains(@class,'NavText') and contains(text(),'Työpaikat')]
    Wait Until Location Is           ${url}add/companyname  5


# OK
Go To Contractpage
    [Tags]  navigate  valid
    Open Hamburgermenu
    Wait Until Element Is Visible    xpath=//p[contains(@class,'NavText') and contains(text(),'Luo uusi sopimus')]  5
    Click Element                    xpath=//p[contains(@class,'NavText') and contains(text(),'Luo uusi sopimus')]
    Wait Until Location Is           ${url}evaluation-form  5



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
    [Arguments]  ${email}  ${password}  ${firstname}  ${user_type}
    Location Should Be          ${url}login
    Input Text                  id:email     ${email}
    Input Password              id:password  ${password}
    Click Element               xpath=//div[@class="button__text" and text()="Kirjaudu sisään"]
    Wait Until Location Is Not  ${url}login  5

    IF    '${USER_TYPE}' == 'customer'
        Location Should Contain     ${url}unit-list
        Page Should Contain         Tervetuloa, ${firstname}
    ELSE
    Location Should Be          ${url}
    Page Should Contain         Tervetuloa ${firstname}
    END



# OK
Open Hamburgermenu
    [Tags]  valid  menu
    Wait Until Element Is Visible   xpath=//*[@id="root"]/div/div/div[1]/div[2]/button  5
    Click Element                   xpath=//*[@id="root"]/div/div/div[1]/div[2]/button
    Wait Until Page Contains        Kirjaudu ulos   5

# OK
Login User
    [Tags]  login  navigate  valid
    [Arguments]  ${email}  ${password}  ${firstname}  ${user_type}
    Go To Loginpage
    Enter Login Credentials  ${email}  ${password}  ${firstname}  ${user_type}

# OK
Logout User
    [Tags]  logout  valid
    Open Hamburgermenu

    Wait Until Element Is Visible   xpath=//p[text()="Kirjaudu ulos"]   5
    Click Element                   xpath=//p[text()="Kirjaudu ulos"]

    Page Should Contain Element     xpath=//div[@class="button__text" and text()="Kirjaudu sisään"]
    Page Should Contain             Kirjaudu sisään



# OK
Forgotten Password Case
    [Tags]  valid  email
    [Arguments]  ${email}
    Go To Loginpage
    Click Link                  css:a[href="/forgot-password"]
    Wait Until Location Is      ${url}forgot-password  5
    Input Text                  id:email    ${email}
    Click Element               xpath=//div[@class="button__text" and text()="Lähetä"]
    Page Should Contain         Tarkista sähköpostisi
    Wait Until Location Is Not  ${url}forgot-password  5

# OK
Forgotten Password Invalid Email
    [Tags]  invalid  email  navigate
    [Arguments]  ${email}
    Go To Loginpage
    Click Link                  css:a[href="/forgot-password"]
    Wait Until Location Is      ${url}forgot-password  5
    Input Text                  id:email    ${email}
    Click Element               xpath=//div[@class="button__text" and text()="Lähetä"]
    Page Should Not Contain     Tarkista sähköpostisi
    Location Should Be          ${url}forgot-password

# OK
Search And Select Degree
    [Arguments]  ${degree}  ${searchterm}
    Location Should Be              ${url}degrees/add
    ${classname}=                   Set Variable  addDegree__container--list
    ${xpath}=                       Set Variable  //*[@id="listContainer"]/div[contains(@class,"${classname}")]/p[text()="${degree}"]
    Wait Until Element Is Visible   xpath=//*[@id="root"]/div/div/div[2]/main/div/section/div[1]/input  5
    Input Text                      xpath=//*[@id="root"]/div/div/div[2]/main/div/section/div[1]/input  ${searchterm}
    Wait Until Page Contains        ${degree}  5
    Wait Until Element Is Visible   ${xpath}   5
    Click Element                   ${xpath}
    Wait Until Location Is Not      ${url}degrees/add  5



# OK
Get WorkerId
    [Arguments]  ${firstname}  ${lastname}
    Go To FrontPage
    ${fullname}=              Evaluate   '${firstname}${SPACE}${lastname}'
    Wait Until Page Contains  ${fullname}  5

    Page Should Contain Element    xpath=//*[contains(@class, "customerList__element")]//*[text()="${firstname}" and text()="${lastname}"]
    Click Element                  xpath=//*[contains(@class, "customerList__element")]//*[text()="${firstname}" and text()="${lastname}"]

    Location Should Contain   ${url}unit-list
    ${current_url}=           Get Location
    ${id}=                    Evaluate    "${current_url}".split("/")[-1]
    Return From Keyword       ${id}


# OK, used for deleting from database
Get DegreeId
    [Arguments]  ${degreename}  ${searchterm}
    Go To Degreespage
    Search And Select Degree  ${degreename}  ${searchterm}
    ${current_url}=           Get Location
    ${id}=                    Evaluate    "${current_url}".split("/")[-1]
    Return From Keyword       ${id}



# OK, used when deleting from database
Get JobId
    [Arguments]  ${companyname}  ${searchterm}
    Go To Jobpage
    Search And Select Job    ${companyname}  ${searchterm}

    ${current_url}=          Get Location
    ${id}=                   Evaluate    "${current_url}".split("/")[-1]
    Return From Keyword      ${id}



# OK
Modify Degreename With Save
    [Tags]  valid  modify  navigate
    [Arguments]  ${new_degreename}
    Wait Until Element Is Visible   xpath=//*[@id="root"]/div/div/div[2]/main/section/div[1]/h1/span/div  5
    Click Element                   xpath=//*[@id="root"]/div/div/div[2]/main/section/div[1]/h1/span/div
    Wait Until Element Is Visible   xpath=//*[@id="outlined-multiline-static"]  5
    Click Element                   xpath=//*[@id="outlined-multiline-static"]
    Press Keys                      xpath=//*[@id="outlined-multiline-static"]  COMMAND+a   BACKSPACE
    Input Text                      xpath=//*[@id="outlined-multiline-static"]  ${new_degreename}

    Click Element                   xpath=//div[@class="button__text" and text()="Tallenna"]
    Page Should Contain             Tiedot tallennettu
    Click Button                    xpath=//*[@id="customized-dialog-title"]/button

# OK
Modify Degreename Without Save
    [Arguments]  ${degree}  ${new_degreename}
    Wait Until Element Is Visible   xpath=//*[@id="root"]/div/div/div[2]/main/section/div[1]/h1/span/div  5
    Click Element                   xpath=//*[@id="root"]/div/div/div[2]/main/section/div[1]/h1/span/div
    Wait Until Element Is Visible   xpath=//*[@id="outlined-multiline-static"]  5
    Click Element                   xpath=//*[@id="outlined-multiline-static"]
    Press Keys                      xpath=//*[@id="outlined-multiline-static"]  COMMAND+a   BACKSPACE
    Input Text                      xpath=//*[@id="outlined-multiline-static"]  ${new_degreename}
    Click Button                    xpath=/html/body/div[2]/div[3]/div/div/div/button

    # validate that the information is not updated
    Page Should Not Contain         ${new_degreename}
    Page Should Contain             ${degree}
    Reload Page
    Page Should Not Contain         ${new_degreename}
    Page Should Contain             ${degree}

# OK
Modify Degreename
    [Arguments]  ${degree}  ${new_degreename}  ${searchterm}
    Modify Degreename With Save     ${new_degreename}

    # Validate the modification
    Go To Degreespage
    Search And Select Degree        ${new_degreename}  ${searchterm}

    # Change back to original degree
    Modify Degreename With Save     ${degree}
    Go To Degreespage
    Search And Select Degree        ${degree}  ${searchterm}

    Modify Degreename Without Save  ${degree}  ${new_degreename}


# OK
Delete Degreepart Cancel
    [Arguments]  ${partname}  ${xpath}  ${button_xpath}

    Page Should Contain            ${partname}
    # element with partname
    Wait Until Element Is Visible  ${xpath}  5
    Wait Until Element Is Visible  ${button_xpath}  5
    Click Element                  ${button_xpath}

    # delete modal
    Page Should Contain Element    xpath=//*[contains(@class, "button__container")]//*[contains(@class, "button__text") and text()="Peruuta"]
    Page Should Contain Element    xpath=//*[contains(@class, "button__container")]//*[contains(@class, "button__text") and text()="Kyllä, arkistoi"]
    Click Element                  xpath=//*[contains(@class, "button__container")]//*[contains(@class, "button__text") and text()="Peruuta"]
    Page Should Contain            ${partname}

    Reload Page
    Page Should Contain            ${partname}
    Wait Until Element Is Visible  ${xpath}  5
    Wait Until Element Is Visible  ${button_xpath}  5
    Click Element                  ${button_xpath}
    Page Should Contain Element    xpath=//*[contains(@class, "button__container")]//*[contains(@class, "button__text") and text()="Peruuta"]
    Page Should Contain Element    xpath=//*[contains(@class, "button__container")]//*[contains(@class, "button__text") and text()="Kyllä, arkistoi"]

    # x button
    Page Should Contain Button     xpath=//*[@id="customized-dialog-title"]/button
    Click Button                   xpath=//*[@id="customized-dialog-title"]/button
    Page Should Contain            ${partname}

    Reload Page
    Page Should Contain            ${partname}


Delete Degreepart Confirm
    [Arguments]  ${partname}  ${xpath}  ${button_xpath}

    Page Should Contain            ${partname}
    # element with partname
    Wait Until Element Is Visible  ${xpath}  5
    Wait Until Element Is Visible  ${button_xpath}  5
    Click Element                  ${button_xpath}

    # delete modal
    Page Should Contain Element    xpath=//*[contains(@class, "button__container")]//*[contains(@class, "button__text") and text()="Peruuta"]
    Page Should Contain Element    xpath=//*[contains(@class, "button__container")]//*[contains(@class, "button__text") and text()="Kyllä, arkistoi"]
    Click Element                  xpath=//*[contains(@class, "button__container")]//*[contains(@class, "button__text") and text()="Kyllä, arkistoi"]

    # delete confirmation here?

    Page Should Not Contain        ${partname}
    Reload Page
    Page Should Not Contain        ${partname}

# OK
Add Customerinfo
    Location Should Be               ${url}evaluation-form

    # customerinfo
    Wait Until Element Is Visible    xpath=//*[@id="firstName"]  5
    Input Text                       xpath=//*[@id="firstName"]  ${test_customer_firstname}
    Wait Until Element Is Visible    xpath=//*[@id="lastName"]  5
    Input Text                       xpath=//*[@id="lastName"]  ${test_customer_lastname}
    Wait Until Element Is Visible    xpath=//*[@id="email"]  5
    Input Text                       xpath=//*[@id="email"]  ${test_customer_email}

    # startdate
    Wait Until Element Is Visible    xpath=//*[@id="root"]/div/div/div[2]/main/div/section/form/div[4]/div[1]/div/div/button  5
    Click Element                    xpath=//*[@id="root"]/div/div/div[2]/main/div/section/form/div[4]/div[1]/div/div/button
    Click Element                    xpath=/html/body/div[2]/div[2]/div/div/div/div[2]/div/div/div[2]/div/div[2]/button[2]

    #enddate
    Wait Until Element Is Visible    xpath=//*[@id="root"]/div/div/div[2]/main/div/section/form/div[4]/div[2]/div/div/button  5
    Click Element                    xpath=//*[@id="root"]/div/div/div[2]/main/div/section/form/div[4]/div[2]/div/div/button
    Click Element                    xpath=/html/body/div[2]/div[2]/div/div/div/div[1]/div[2]/button[2]
    Click Element                    xpath=/html/body/div[2]/div[2]/div/div/div/div[2]/div/div/div[2]/div/div[3]/button[5]

    #input fields
    Wait Until Element Is Visible    xpath=//*[@id="workTasks"]  5
    Input Text                       xpath=//*[@id="workTasks"]  ${job_description}
    Wait Until Element Is Visible    xpath=//*[@id="workGoals"]  5
    Input Text                       xpath=//*[@id="workGoals"]  ${personal_goals}

    Scroll Element Into View         xpath=//div[@class="button__text" and text()="Seuraava"]
    Wait Until Element Is Visible    xpath=//div[@class="button__text" and text()="Seuraava"]  5

    # this section (select teacher) might move to another page later!
    Wait Until Element Is Visible  xpath=//*[@id="root"]/div/div/div[2]/main/div/section/form/div[8]/div/div/div/div/button  5
    Click Button                   xpath=//*[@id="root"]/div/div/div[2]/main/div/section/form/div[8]/div/div/div/div/button
    Press Keys                      None   UP
    Press Keys                      None   UP
    Press Keys                      None   UP
    Press Keys                      None   UP
    Press Keys                      None   ENTER
    #

    Click Element                    xpath=//div[@class="button__text" and text()="Seuraava"]
    Wait Until Location Is Not       ${url}evaluation-form  5


# OK
Add Customer
    Go To Contractpage
    Add Customerinfo
    Select Workplace and Supervisor
    Select Workplace Parts
    Location Should Be               ${url}evaluation-summary
    Wait Until Element Is Visible    xpath=//div[@class="button__text" and text()="Lähetä kutsut"]  5
    Click Element                    xpath=//div[@class="button__text" and text()="Lähetä kutsut"]
    Page Should Contain              Kutsut lähetetty!
    Page Should Contain              Sopimukseen liitetyille henkilöille on lähetetty kirjautumiskutsut.
    # close popup with ESC
    Press Keys                       None  '\ue00c'


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