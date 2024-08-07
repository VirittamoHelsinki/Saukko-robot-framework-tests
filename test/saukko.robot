*** Settings ***
Library         SeleniumLibrary
Library         OperatingSystem
Library         Collections
Library         DateTime
Resource        saukko-keywords.robot
Resource        management-teacher-keywords.robot
Resource        management-supervisor-keywords.robot
Resource        management-customer-keywords.robot
Resource        saukko-variables.robot
Suite Setup     Open Browserwindow
Suite Teardown  Close Browser


*** Test Cases ***
Login Logout (teacher)
    Login User  ${test_teacher_email}  ${test_teacher_pw}  ${test_teacher_firstname}
    Logout User


Login Logout (supervisor)
    Login User  ${test_supervisor_email}  ${test_supervisor_pw}  ${test_supervisor_firstname}
    Logout User


Login Logout (customer)
    # credentials not working
    Login User  ${customer1.e-mail}  ${customer1.password}  ${customer1.name}
    Logout User


# UNFINISHED
Forgotten Password (all usertypes)
    Forgotten Password Case  ${test_teacher_email}
    Forgotten Password Case  ${test_supervisor_email}
    # Forgotten Password Case  ${test_customer_email}


Forgotten Password Invalid Input
    Forgotten Password Invalid Email   testi.com
    Forgotten Password Invalid Email   testi@
    Forgotten Password Invalid Email   testi@test
    Forgotten Password Invalid Email   .yahoo
    Forgotten Password Invalid Email   testi@testi@testi@testi.com


Change Password (supervisor)
    ${temp_pw}=       Set Variable  ${test_supervisor_pw}abc123!
    Login User        ${test_supervisor_email}  ${test_supervisor_pw}  ${test_supervisor_firstname}
    Change Password   ${test_supervisor_pw}  ${temp_pw}
    Logout User
    Login User        ${test_supervisor_email}  ${temp_pw}  ${test_supervisor_firstname}
    Change Password   ${temp_pw}  ${test_supervisor_pw}
    Logout User
    Login User        ${test_supervisor_email}  ${test_supervisor_pw}  ${test_supervisor_firstname}


Change Password (teacher)
    ${temp_pw}=       Set Variable  ${test_teacher_pw}abc123!
    Login User        ${test_teacher_email}  ${test_teacher_pw}  ${test_teacher_firstname}
    Change Password   ${test_teacher_pw}  ${temp_pw}
    Logout User
    Login User        ${test_teacher_email}  ${temp_pw}  ${test_teacher_firstname}
    Change Password   ${temp_pw}  ${test_teacher_pw}
    Logout User
    Login User        ${test_teacher_email}  ${test_teacher_pw}  ${test_teacher_firstname}


# CREDENTIALS NOT WORKING
Change Password (customer)
    ${temp_pw}=       Set Variable  ${test_customer_pw}abc123!
    Login User        ${test_customer_email}  ${test_customer_pw}  ${test_customer_firstname}
    Change Password   ${test_customer_pw}  ${temp_pw}
    Logout User
    Login User        ${test_customer_email}  ${temp_pw}  ${test_customer_firstname}
    Change Password   ${temp_pw}  ${test_customer_pw}
    Logout User
    Login User        ${test_customer_email}  ${test_customer_pw}  ${test_customer_firstname}


#    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #
#    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #
#    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #
#    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #
#    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #    #


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
