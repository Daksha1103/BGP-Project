*** Settings ***
Library    SeleniumLibrary    

*** Variables ***
${Browser}    Chrome
${URL}    https://public:Let$BeC001@bgp-qa.gds-gov.tech/
# ${NameTextBox}    xpath://input[@id='react-contact_info-name']    
# &{Contact_Info}    Name=David    Job Title=Marketing Manager    Contact No=91223344    Email=David11@gmail.com    Alt Personal Email=David22@gmail.com   
${NRIC}    S1234567A
${NAME}    Tan Ah Kow
${UEN}    BGPQEDEMO

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
# ${ACTIVITY}    Identification of Potential Overseas Partners
${TARGET_MARKET}    India
${Type of Entity}    subsidiary
${Percentage Shareholdings}    70 
${REMARKS}    Remarks on Projects
${NEXT}    id=next-btn
${SAVE}    id=save-btn 
${Image_Path}   Images
${File_Name}    MRT.jpg
${FY_END_DATE}    30 Jun 2020
${OVERSEAS_SALES_0}    100,000
${OVERSEAS_SALES_1}    200,000
${OVERSEAS_SALES_2}    300,000
${OVERSEAS_SALES_3}    350,000
${OVERSEAS_INVEST_0}    170,000
${OVERSEAS_INVEST_1}    200,000
${OVERSEAS_INVEST_2}    350,000
${OVERSEAS_INVEST_3}    400,000
${ACTIVITY}    xpath://*[contains(text(), 'Activity')]/../../following-sibling::*//div/div/span/div[contains(text(), 'Select')]
${ACTIVITY_LIST}    xpath://div[text()='Market Entry']
*** Keywords ***
Applicant key in Credentials
   [Documentation]    Verify Applicant is able to Login with his credentials for BGP
   Input Text    name=CPUID    ${NRIC}
   Input Text    name=CPUID_FullName   ${NAME}   
   Input Text    name=CPEntID    ${UEN}    
   Select From List By Label   CPRole     Acceptor       
   Click Button    xpath://div[2]/form[2]/button[@type='submit'] 
   
Applicant open the browser
   Open Browser    ${URL}    ${Browser}
   Maximize Browser Window
   Set Browser Implicit Wait    5
   Click Element    id=login-button
   
I apply for New Grant
   [Documentation]   Applicant Opens browser and keyin credentials
   Applicant open the browser
   Applicant key in Credentials

I Get New Grant
   [Documentation]    Applicant to I Get New Grant to proceed
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
I Check for Eligibility Questions
   [Documentation]   Verify eligibility 5 questions for applicant to I Get New Grant
   I Get New Grant
   Click Element    xpath://div[4]//div[1]//div[2]//label[1]//span[1]
   Click Element    xpath://div[5]//div[1]//div[2]//label[1]//span[1]
   Click Element    xpath://div[6]//div[1]//div[2]//label[1]//span[1]
   Click Element    xpath://div[7]//div[1]//div[2]//label[1]//span[1]
   Click Element    xpath://div[8]//div[1]//div[2]//label[1]//span[1]
   Click Button     ${SAVE}

I key in my Personal Contact Info
   Input Text    ${CONTACT_NAME}    David
   Input Text    ${CONTACT_DESIGNATION}  Marketing Manager
   Input Text    ${CONTACT_PHONE_NO}     91445566
   Input Text    ${CONTACT_EMAIL_ID}    David11@gmail.com 
   Input Text    ${CONTACT_SEC_EMAIL_ID}      David22@gmail.com

I key in my Personal Address Info
   Input Text    id=react-contact_info-correspondence_address-postal    ${POSTAL CODE}     
   Click Element    xpath://span[@class='glyphicon glyphicon-search search-icon-logo'] 
   Sleep    3   
   Input Text    id=react-contact_info-correspondence_address-level    ${ADD_LEVEL}
   Input Text    id=react-contact_info-correspondence_address-unit    ${ADD_UNIT}     
   Input Text    id=react-contact_info-correspondence_address-building_name     ${ADD_BUILDING}    
   Click Element    id:react-contact_info-copied
   Click Button    ${SAVE} 
   
I key in all Mandatory fields in Proposal Page
    Input Text    id=react-project-title    ${PROJECT TITLE}  
    Input Text    id=react-project-start_date    ${START_DATE}
    Input Text    id=react-project-end_date    ${END_DATE}    
    Input Text    id=react-project-description    The Business Grants Portal is a one-stop portal for businesses to apply for grants according to their needs without having to approach multiple agencies. 
   Click Element   ${ACTIVITY}
   Click Element   ${ACTIVITY_LIST}   
   Input Text    id=react-project-entity_type    ${Type of Entity}
   Input Text    id=react-project-shareholding_percentage    ${Percentage Shareholdings}   
   Click Element   xpath://span[@id='react-select-project-primary_market--value']
   Click Element   xpath://div[text()='India']  
   Click Element   xpath://div[@class='controls bgp-radio-text-format']//label[1]//span[1]  
   Choose File    xpath://input[@type='file']   ${EXECDIR}${/}${Image_Path}${/}${File_Name} 
   Sleep    10
   Input Text    id=react-project-remarks    No Remarks
   Click Button     ${SAVE} 
   Click Button     ${NEXT}
   
 I key in all Mandatory fields in Explain the Business Impact Page 
   Input Text    id=react-project_impact-fy_end_date_0    ${FY_END_DATE}
   Input Text    id=react-project_impact-overseas_sales_0    ${OVERSEAS_SALES_0}
   Input Text    id=react-project_impact-overseas_sales_1    ${OVERSEAS_SALES_1}
   Input Text    id=react-project_impact-overseas_sales_2    ${OVERSEAS_SALES_2}
   Input Text    id=react-project_impact-overseas_sales_3    ${OVERSEAS_SALES_3}
   Input Text    id=react-project_impact-overseas_investments_0    ${OVERSEAS_INVEST_0}
   Input Text    id=react-project_impact-overseas_investments_1    ${OVERSEAS_INVEST_1}
   Input Text    id=react-project_impact-overseas_investments_2    ${OVERSEAS_INVEST_2}
   Input Text    id=react-project_impact-overseas_investments_3    ${OVERSEAS_INVEST_3}
   Sleep    2     
   Input Text    id=react-project_impact-rationale_remarks    To develop business
   Input Text    id= react-project_impact-benefits_remarks    To Publicity
   Click Button     ${SAVE} 
   Click Button     ${NEXT}   

 I key in all Mandatory fields in Provide Details Of Costs
    Click Element    id=react-project_cost-vendors-accordion-header
    Click Element    id=react-project_cost-vendors-add-item
    Click Element    xpath://label[2]//span[1]
    Input Text     id=react-project_cost-vendors-0-vendor_name    Adrian Tan
    Choose File    xpath://input[@type='file']   ${EXECDIR}${/}${Image_Path}${/}${File_Name}
    Sleep    5 
    Input Text    id=react-project_cost-vendors-0-amount_in_billing_currency    100,000,000
    Input Text    id=react-project_cost-remarks    No Remarks
    Click Button     ${SAVE} 
    Click Button     ${NEXT}

 I key in all Mandatory fields in declare And Acknowledge Terms
    Click Element    xpath://li[1]//div[1]//div[2]//label[1]//span[1]
    Click Element    xpath://li[2]//div[1]//div[2]//label[1]//span[1]
    Click Element    xpath://li[3]//div[1]//div[2]//label[1]//span[1]
    Click Element    xpath://li[4]//div[1]//div[2]//label[1]//span[1]
    Click Element    xpath://li[5]//div[1]//div[2]//label[1]//span[1]
    Click Element    xpath://li[6]//div[1]//div[2]//label[1]//span[1]
    Click Element    xpath://li[7]//div[1]//div[2]//label[1]//span[1]
    Click Element    xpath://li[8]//div[1]//div[2]//label[2]//span[1]
    Click Element    xpath://li[9]//div[1]//div[2]//label[2]//span[1]
    Click Element    xpath://input[@id='react-declaration-consent_acknowledgement_check']
    Click Button     ${SAVE} 

*** Test Cases ***

Applicant Login to BGP
   [Documentation]    This is a simple login test
   I apply for New Grant
   Close Browser
   Log    TestComplete   
   
US-1 TC01 Check for Eligibility Questions for Grant Access
    [Documentation]    Verify Eligibility questions for new grant
    Given I apply for New Grant
    When I Check for Eligibility Questions
    Then Capture Page Screenshot
    And Close Browser
    Log    TestComplete 
   
US-1 TC02 Grant Access Not Eligible and open FAQ URL
       
   [Documentation]    Verify the eligibility section for one negative answer and open new windown for FAQ
   Given I apply for New Grant
   When I Get New Grant
   Then Click Element    xpath://div[4]//div[1]//div[2]//label[1]//span[1]
   Then Click Element    xpath://div[5]//div[1]//div[2]//label[1]//span[1]
   Then Click Element    xpath://div[6]//div[1]//div[2]//label[1]//span[1]
   Then Click Element    xpath://div[7]//div[1]//div[2]//label[1]//span[1]
   Then Click Element    xpath://div[8]//div[1]//div[2]//label[2]//span[1]
   Then Click Link    xpath://span[contains(text(),'The applicant may not meet the eligibility criteri')]//a[contains(text(),'FAQ')]
   And Capture Page Screenshot
  
   # Close Browser
   Log    TestComplete 
   
US-2 TC01 Contact Details Section and save
   [Documentation]    Applicant should be able to input values for the Main Contact Person and Letter of Offeree in the Contact Details page.
   Given I apply for New Grant
   When I Check for Eligibility Questions
   Sleep     2
   Then Click Button      ${NEXT}
   And I key in my Personal Contact Info
   Then Click Element    id:react-contact_info-correspondence_address-copied  
   Then Click Element    id:react-contact_info-copied
   And Click Button    ${SAVE} 
   # Close Browser
   Log    TestComplete 
   
US-2 TC02 Contact Details Section_Auto_Populate_Corresponding_address and Save
   [Documentation]    Valid Postal code to auto-populate upon clicking on search   
   Given I apply for New Grant
   When I Check for Eligibility Questions
   Sleep     2
   Then Click Button      ${NEXT}
   Then I key in my Personal Contact Info
   Then I key in my Personal Address Info
   And Click Button     ${NEXT}
   Log    TestComplete 
   
US-3 TC01 Form Submission
    [Documentation]    To Verify Applicant to successfully submit the form
    Given I apply for New Grant
    When I Check for Eligibility Questions
    Then Sleep     2
    And Click Button     ${NEXT}
    Then I key in my Personal Contact Info
    Then I key in my Personal Address Info
    And Click Button      ${NEXT}
    Then Sleep    2
    And I key in all Mandatory fields in Proposal Page
    And I key in all Mandatory fields in Explain the Business Impact Page 
    Then Sleep    2
    Then I key in all Mandatory fields in Provide Details Of Costs
    Then I key in all Mandatory fields in declare And Acknowledge Terms
    And Click Button     id=review-btn
    Then Click Element    id=react-declaration-info_truthfulness_check
    And Click Button    id=submit-btn
         
    Log    TestComplete 
   

    
          