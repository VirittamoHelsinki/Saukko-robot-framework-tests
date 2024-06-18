*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Library     Collections
Library     DateTime
Resource    saukko-keywords.robot
Resource    management-teacher-keywords.robot
Resource    management-supervisor-keywords.robot
Resource    management-customer-keywords.robot





*** Test Cases ***
Login-Logout (teacher)
    
    First page
    # Right Click And Select Inspect    xpath=//div[@id='root']

    # Login and logout
    Login as teacher
    Wait Until Element Is Visible   xpath=//div[@class="${hamburger-menu}"]    15
    Logout as teacher

    Click Element    xpath=//section[@class="landingPage__buttons"]//button[@class="button__container "]

    # Forgot Password
    Forgotten password case

    Close Browser


Degree Management page (teacher)
    First page
    Login as teacher
    Degree Management pages as teacher
    Close Browser

Work place management page (teacher)
    First page
    Login as teacher
    Work Place Management as teacher
    Close Browser
    
Degree activation page (teacher)
    First page
    Login as teacher
    Sleep    3
    Degree activation as teacher


General management pages (teacher)
    First page
    Login as teacher
    General management page as teacher
    

Login-Logout (supervisor)
    First page
    # Right Click And Select Inspect    xpath=//div[@id='root']

    # Login and logout
    Login as supervisor
    Logout as supervisor
    Close Browser

    # Click on "Kirjaudu sisään" on main page
    First page

    # Forgot Password
    Forgotten password case

    Close Browser

General management pages (supervisor)
    First page
    Login as supervisor
    General management page as supervisor
    


Login-Logout (customer)
    First page
    Login as customer
    Logout as customer
    Close Browser

General management pages (customer)
    First page
    Login as customer
    General management page as customer
    