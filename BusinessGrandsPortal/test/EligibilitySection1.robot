*** Settings ***
Library    SeleniumLibrary    

*** Variables ***
${Browser}    Chrome
${URL}    https://public:Let$BeC001@bgp-qa.gds-gov.tech/
# ${NameTextBox}    xpath://input[@id='react-contact_info-name']    
# &{Contact_Info}    Name=David    Job Title=Marketing Manager    Contact No=91223344    Email=David11@gmail.com    Alt Personal Email=David22@gmail.com   
${CONTACT_NAME}     xpath://input[@id='react-contact_info-name']
${CONTACT_DESIGNATION}    xpath://input[@id='react-contact_info-designation']
${CONTACT_PHONE_NO}    xpath://input[@id='react-contact_info-phone']
${CONTACT_EMAIL_ID}    xpath://input[@id='react-contact_info-primary_email'] 
${CONTACT_SEC_EMAIL_ID}     xpath://input[@id='react-contact_info-secondary_email'] 
${POSTAL CODE}    543318  
${ADD_LEVEL}    10
${ADD_UNIT}    200
${ADD_BUILDING}    123C
${PROJECT TITLE}   GDS
${START_DATE}    01 Aug 2020
${END_DATE}    01 Nov 2020
${ACTIVITY}    Identification of Potential Overseas Partners
${TARGET_MARKET}    India
${Type of Entity}    subsidiary
${Percentage Shareholdings}    70 
${REMARKS}    Remarks on Projects
${NEXT}    id=next-btn
${SAVE}    id=save-btn 

*** Keywords ***
LoginBGP
   [Documentation]    Login credentials for BGP
   Input Text    name=CPUID    S1234567A
   Input Text    name=CPUID_FullName   Tan Ah Kow   
   Input Text    name=CPEntID    BGPQEDEMO    
   Select From List By Label   CPRole     Acceptor       
   Click Button    xpath://div[2]/form[2]/button[@type='submit'] 
   
BrowserOpen
   Open Browser    ${URL}    ${Browser}
   Maximize Browser Window
   Set Browser Implicit Wait    5
   # Capture Page Screenshot
   Click Element    id=login-button
   
ApplicantLogin
   [Documentation]   Applicant Opens browser and keyin credentials
   BrowserOpen
   LoginBGP

GetNewGrant
   [Documentation]    Applicant to get new grant to proceed
   Set Browser Implicit Wait    15
   Click Element    xpath://h4[text()='Get new grant']
   Sleep    3
   execute javascript   window.scrollTo(0,1500)
   Click Element    xpath://div[contains(text(),'IT')]
   Sleep    2
   Click Element    xpath://div[contains(text(),'Bring my business overseas or establish a stronger')]
   Click Element    xpath://div[contains(text(),'Market Readiness Assistance')]
   Sleep    2
   Click Button    xpath://button[@id='go-to-grant']
   Sleep    2
   Click Element    id=keyPage-form-button
   Sleep    2   
Grant Access Eligibility and Save
   [Documentation]    Eligibility 5 questions for applicant to get new grant and save
   GetNewGrant
   Click Element    xpath://div[4]//div[1]//div[2]//label[1]//span[1]
   Click Element    xpath://div[5]//div[1]//div[2]//label[1]//span[1]
   Click Element    xpath://div[6]//div[1]//div[2]//label[1]//span[1]
   Click Element    xpath://div[7]//div[1]//div[2]//label[1]//span[1]
   Click Element    xpath://div[8]//div[1]//div[2]//label[1]//span[1]
   Click Button     ${SAVE}

Personal Contact Info
   Input Text    ${CONTACT_NAME}    David
   Input Text    ${CONTACT_DESIGNATION}  Marketing Manager
   Input Text    ${CONTACT_PHONE_NO}     91445566
   Input Text    ${CONTACT_EMAIL_ID}    David11@gmail.com 
   Input Text    ${CONTACT_SEC_EMAIL_ID}      David22@gmail.com

Personal Address Info
   Input Text    id=react-contact_info-correspondence_address-postal    ${POSTAL CODE}     
   Click Element    xpath://span[@class='glyphicon glyphicon-search search-icon-logo'] 
   Sleep    3   
   Input Text    id=react-contact_info-correspondence_address-level    ${ADD_LEVEL}
   Input Text    id=react-contact_info-correspondence_address-unit    ${ADD_UNIT}     
   Input Text    id=react-contact_info-correspondence_address-building_name     ${ADD_BUILDING}    
   Click Element    id:react-contact_info-copied
   Click Button    ${SAVE} 
   

*** Test Cases ***

BgpLogIn
   [Documentation]    This is a simple login test
   Given ApplicantLogin
   Close Browser
   Log    TestComplete   
   
US-1 TC01 Grant Access Eligibility and Save
    
   [Documentation]    Eligibility questions for get new grant
    ApplicantLogin
    Grant Access Eligibility and Save
    Capture Page Screenshot
   # Close Browser
   Log    TestComplete 
   
US-1 TC02 Grant Access Not Eligible and open FAQ URL
       
   [Documentation]    To check the eligibility section for all for one negative answer and open new windown for FAQ
   ApplicantLogin
   GetNewGrant
   Click Element    xpath://div[4]//div[1]//div[2]//label[1]//span[1]
   Click Element    xpath://div[5]//div[1]//div[2]//label[1]//span[1]
   Click Element    xpath://div[6]//div[1]//div[2]//label[1]//span[1]
   Click Element    xpath://div[7]//div[1]//div[2]//label[1]//span[1]
   Click Element    xpath://div[8]//div[1]//div[2]//label[2]//span[1]
   Click Link    xpath://span[contains(text(),'The applicant may not meet the eligibility criteri')]//a[contains(text(),'FAQ')]
   Capture Page Screenshot
   # Close Browser
   Log    TestComplete 
   
US-2 TC01 Contact Details Section and save
   [Documentation]    Applicant should be able to input values for the Main Contact Person and Letter of Offeree in the Contact Details page.
   ApplicantLogin
   Grant Access Eligibility and Save
   Sleep     2
   Click Button      ${NEXT}
   Personal Contact Info
   Click Element    id:react-contact_info-correspondence_address-copied  
   Click Element    id:react-contact_info-copied
   Click Button    ${SAVE} 
   # Close Browser
   Log    TestComplete 
   
US-2 TC02 Contact Details Section_Auto_Populate_Corresponding_address and Save
   [Documentation]    Valid Postal code to auto-populate upon clicking on search   
   ApplicantLogin
   Grant Access Eligibility and Save
   Sleep     2
   Click Button      ${NEXT}
   Personal Contact Info
   Personal Address Info
   Click Button     ${NEXT}
   Log    TestComplete 
   
US-3 TC01 Proposal Page and Save
    [Documentation]    An Applicant proposal page
    ApplicantLogin
    Grant Access Eligibility and Save
    Sleep     2
    Click Button     ${NEXT}
    Personal Contact Info
    Personal Address Info
    Click Button      ${NEXT}
    Sleep    2
    # Proposal Page
    Input Text    id=react-project-title    ${PROJECT TITLE}  
    Input Text    id=react-project-start_date    ${START_DATE}
    Input Text    id=react-project-end_date    ${END_DATE}    
    Input Text    id=react-project-description    The Business Grants Portal is a one-stop portal for businesses to apply for grants according to their needs without having to approach multiple agencies.
     
   Click Element   xpath://*[contains(text(), 'Activity')]/../../following-sibling::*//div/div/span/div[contains(text(), 'Select')]
   Click Element   xpath://div[text()='Market Entry']   
   Input Text    id=react-project-entity_type    ${Type of Entity}
   Input Text    id=react-project-shareholding_percentage    ${Percentage Shareholdings}   
   Click Element   xpath://span[@id='react-select-project-primary_market--value']
   Click Element   xpath://div[text()='India']  
   Click Element   xpath://div[@class='controls bgp-radio-text-format']//label[1]//span[1]  
   
   # Choose File   id=react-project-attachments-btn   ${EXECDIR}${/}Images{/}MRT.jpg
   # Choose File    xpath://button[@id='react-project-attachments-btn']   ${EXECDIR}${/}Images${/}MRT.jpg
   # Choose File    xpath://input[@type='file']    ${EXECDIR}${/}Images${/}MRT.jpg
   Choose File    xpath://input[@type='file']   ${EXECDIR}${/}Images{/}MRT.jpg
   Sleep    10
   Click Button     ${SAVE} 
   Click Button     ${NEXT}
   
   

    Log    TestComplete 
    
          