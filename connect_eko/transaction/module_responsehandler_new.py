#copyright @ Eko India Financial Service Pvt. Ltd.
'''
Modified  on JUN 15, 2014

@author: siddharth,Kunal
'''
#This file generayes different status depending upon the responses 
# and depending upon that responses we change the frontend

from transaction import module_helper
import re
import json
from master import constants

def get_formatted_response(result_text):
    return "<br/>".join(result_text.split("\n"))

def get_formatted_response_data(result_text):
    response = 'Transaction Id: '+str(result_text['tid'])+'\nTransaction Description: '+str(result_text['tx_desc'])+'\nService tax: '+str(result_text['service_tax'])+'\nCurrency: '+str(result_text['currency'])+'\nAmount: '+str(result_text['amount'])+'\nFee: '+str(result_text['fee'])+'\nTimestamp: '+str(result_text['timestamp'])+'\nTransaction Status: '+str(result_text['txstatus_desc'])+'\nSender: '+str(result_text['customer_id'])   
    return response
    
#General response
def check_generic_response(result_text):
    if result_text.lower()[:3] == "sos":
        return ""
    
    elif "you are not allowed to do this transaction" in result_text.lower():
        return constants.TRXN_NOT_ALLOWED_STATUS
        
    elif "error contacting eko server" in result_text.lower():
        return constants.CONN_ERROR_STATUS

    elif "application is not accessible" in result_text.lower():
        return constants.APPLIC_ERROR_STATUS
        
    elif "transaction is in progress" in result_text.lower():
        return constants.TRXN_IN_PROGRESS_STATUS
    
    elif "pin you have entered is incorrect" in result_text.lower():
        return  constants.INCORRECT_PIN_STATUS
    
    elif "service is currently not available" in result_text.lower():
        return constants.SERVICE_UNAVAILABLE_STATUS
    
    elif "please try later" in result_text.lower():
        return constants.SERVICE_UNAVAILABLE_STATUS
    
    elif "to enjoy easy banking" in result_text.lower():
        return constants.INVALID_USER_STATUS
    
    elif "request time-out" in result_text.lower():
        return constants.REQUEST_TIMEOUT_STATUS
    
    else:
        return ''

#To handle the response coming after enrolment of customer.
def icici_enrolment_response(result_text):
    if 'status' not in result_text:
        return constants.UNKNOWN_STATUS

    result_text = json.loads(result_text)
        
    if result_text['response_type_id'] == constants.ENROLMENT_VERIFICATION_PENDING and result_text['response_status_id'] == constants.SUCCESS and result_text['status']==constants.SUCCESS:
        return constants.VERIFICATION_PENDING_STATUS
    elif result_text['response_type_id'] == constants.ENROLLMENT_SUCCESS :
        return constants.ENROLMENT_SUCCESS_STATUS   
    elif result_text['response_type_id'] == constants.ERROR and result_text['response_status_id'] == constants.FAILURE and result_text['status']==constants.ALREADY_ENROLED:
        return constants.ALREADY_ENROLED_STATUS
    else:
        return constants.ENROLMENT_FAILED_STATUS

#To handle the response coming after Get all recipient API call.
def icici_recipient_list_inquiry_reponse(result_text):
    
    if 'status' not in result_text:
        return constants.UNKNOWN_STATUS

    result_text = json.loads(result_text)

    if result_text['response_type_id'] == constants.RECIPIENT_FOUND or result_text['response_type_id'] == constants.NO_RECIPIENT :
        return constants.ENROLLED_STATUS
    else:
        return constants.NOT_ENROLLED_STATUS           

# To handle the response coming after Add Recipient API Call.   
def icici_recipient_registration_response(result_text):
    
    if 'status' not in result_text:
        return constants.UNKNOWN_STATUS

    result_text = json.loads(result_text)
    if result_text['response_type_id'] == constants.ERROR and result_text['status'] == constants.INVALID_ACCOUNT_NUM:
        return constants.RECIPIENT_REG_FAILED_INVALID_ACCOUNT_NUM_STATUS        
    elif result_text['response_type_id'] == constants.ERROR and result_text['status'] == constants.REG_FAILED_INVALID_IFSC:
        return constants.RECIPIENT_REG_FAILED_INVALID_IFSC_STATUS
    elif result_text['response_type_id'] == constants.INVALID_IFSC:
        return constants.RECIPIENT_ALREADY_REGISTERED_STATUS      
    elif result_text['response_type_id'] == constants.RECIPIENT_REG_SUCCESS or result_text['response_type_id'] == constants.REC_REG_SUCCESS:
        return constants.RECIPIENT_REG_SUCCESS_STATUS        
    else:
        return constants.RECIPIENT_REG_FAILED_STATUS 

# To handle the response coming after Get recipient API Call     
def icici_recipient_individual_inquiry_reponse(result_text):
    if 'status' not in result_text:
        return constants.UNKNOWN_STATUS    
    result_text = json.loads(result_text)

    if result_text['response_type_id'] == constants.SUCCESS_INQUIRY:
        return constants.SUCCESS_DISP
    else:
        return constants.FAILED_STATUS

#To handle the response coming after Send money API Call
def icici_moneytransfer_response(result_text):
    if 'status' not in result_text:
        return constants.UNKNOWN_STATUS    
    result_text = json.loads(result_text)
    if result_text['response_type_id'] == constants.VERIFICATION_PENDING:
        return constants.VERIFICATION_PENDING_STATUS
    elif result_text['response_type_id'] == constants.ERROR and result_text['status'] ==constants.INCORRECT_PIN or result_text['response_type_id'] == constants.INVALID_OKKEY:
        return constants.INCORRECT_PIN_STATUS
    elif result_text['response_type_id'] == constants.TX_SUCCESS:   
        return constants.SUCCESS_DISP
    else:
        return constants.FAILURE_DISP    

# For handling the balance inquiry response
def balance_inquiry_response(result_text):
    generic_response = check_generic_response(result_text)
    if generic_response != '':
        return generic_response
    
    if "bal:rs" in result_text.lower() and 'active plan' in result_text.lower():
        return constants.SUCCESS_DISP
    elif 'accept the agreement' in result_text.lower():
        return constants.AGREEMENT_PENDING_STATUS 
    else:
        return constants.FAILURE_DISP

# To get the bank code     
def recipient_individual_inquiry_bank_info(result_text):
    bank_id = str(json.loads(result_text)['data']['ifsc'])
    bank_id = bank_id[:4].lower()           
    return module_helper.get_config_detail_for_bank(bank_id)

# To check if account number exists or not
def account_number_lookup_response(result_text):
    generic_response = check_generic_response(result_text)
    if generic_response != '':
        return generic_response
    
    return constants.SUCCESS_DISP

#To check if User exists or not
def user_reg_lookup_response(result_text):
    generic_response = check_generic_response(result_text)
    if generic_response != '':
        return generic_response
    
    if 'okekey blocked' in result_text.lower():
        constants.OKEKEY_BLOCKED_STATUS
    else:
        return constants.SUCCESS_DISP

#To check if SOS response is available or not
def sos_inquiry_response(result_text):
    generic_response = check_generic_response(result_text)
    if generic_response != '':
        return generic_response
    
    if result_text.lower()[:3] == "sos":
        return constants.SOS_RESPONSE_AVAILABLE_STATUS
    elif "n/a" in result_text.lower():
        return constants.SOS_RESPONSE_NOT_AVAILABLE_STATUS
    else:
        return constants.SOS_FAILED_STATUS

#To check if booklet is available or not    
def booklet_registration_response(result_text):
    generic_response = check_generic_response(result_text)
    if generic_response != '':
        return generic_response
    
    if "booklet registration successful" in result_text.lower() and "last okekey" in result_text.lower():
        return constants.BOOKLET_REG_SUCCESS_STATUS
    elif "enter details in correct format" in result_text.lower():
        return constants.BOOKLET_REG_FAILED_INCORRECT_FORMAT_STATUS
    else:
        return constants.BOOKLET_REG_FAILED_STATUS

#for booklet inquiry    
def booklet_inquiry_response(result_text):
    generic_response = check_generic_response(result_text)
    if generic_response != '':
        return generic_response
    
    if "book number" in result_text.lower() and "total okekey" in result_text.lower():
        return constants.BOOKLET_INQUIRY_SUCCESS_STATUS
    else:
        return constants.BOOKLET_INQUIRY_FAILED_STATUS 

#To handle respnse coming after Get bank details API Call
def bank_config_inquiry_response(result_text):
    generic_response = check_generic_response(result_text)
    if 'status' not in result_text:
        return constants.UNKNOWN_STATUS

    result_text = json.loads(result_text)

    if result_text['response_type_id'] == constants.BANK_CONFIG_INQUIRY_SUCCESS:
        return constants.BANK_CONFIG_INQUIRY_SUCCESS_STATUS
    else:
        return constants.BANK_CONFIG_INQUIRY_FAILED_STATUS
    
    
def post_agreement_consent_response(result_text):
    generic_response = check_generic_response(result_text)
    if generic_response != '':
        return generic_response
    
    if "agreement is signed" in result_text.lower() or "agreement is already" in result_text.lower():
        return constants.SUCCESS_DISP
    else:
        return constants.FAILURE_DISP

#To handle the response coming after Get customer API Call.
def ppi_senderInquiry_response(result_text):
    
    if 'status' not in result_text:
        return constants.UNKNOWN_STATUS    

    result_text = json.loads(result_text)
    
    if result_text["response_type_id"] == constants.ERROR :
        return constants.NOT_ENROLLED_STATUS

    elif result_text['response_type_id'] == constants.VERIFICATION_PENDING:           
        return constants.OTP_VERIFIC_PENDING_STATUS
    
    elif result_text['response_type_id'] == constants.NON_KYC_ACTIVE:
        return constants.NON_KYC_ACTIVE_STATUS

    elif result_text['response_type_id'] == constants.ENROLLMENT_SUCCESS :
        return constants.ENQR_SUCCESS_STATUS    
    else:
        return constants.ENQR_FAILED_STATUS

def extract_response_and_other_config(result_text):
    response = ""
    result = {}
    result['status'] = ppi_senderInquiry_response(result_text)
    if result['status'] != constants.UNKNOWN_STATUS:
        response = str(json.loads(result_text)['message']) 
    else:
        response = result_text
    result['responseText'] = get_formatted_response(response)
    return result

#Customer OTP verification
def ppi_customerotpverification_response(result_text):
    
    if 'status' not in result_text:
        return constants.UNKNOWN_STATUS   
         
    result_text = json.loads(result_text)
    if result_text['response_type_id'] == constants.ENROLLMENT_SUCCESS and result_text['response_status_id'] == constants.SUCCESS and result_text['status']==constants.SUCCESS:
        return constants.ENROLMENT_OTP_VERIFICATION_SUCCESS_STATUS    
    else:
        return constants.ENROLMENT_FAILED_STATUS


#To handle the response coming after Get Acc name info API Call
def recipient_verification_response(result_text):
    if 'status' not in result_text:
        return constants.UNKNOWN_STATUS

    result_text = json.loads(result_text)
    print result_text
    
    if result_text['response_type_id'] == constants.RECIPIENT_VERIFIED : 
        return constants.RECIPIENT_VERIFIED_STATUS
    elif result_text['response_type_id'] == constants.ERROR and result_text['status'] == constants.RECIPIENT_VERIFICATION_INVALID_ACC_NUM:
        return constants.RECIPIENT_VERIFICATION_FAILED_INVALID_ACCOUNT_NUM_STATUS
    elif result_text['response_type_id'] == constants.REC_VERIFICATION_INVALID_IFSC or result_text['status'] == constants.RECIPIENT_VERIFICATION_INVALID_IFSC:
       return constants.RECIPIENT_VERIFICATION_FAILED_INVALID_IFSC_STATUS
    elif result_text['response_type_id'] == constants.RECIPIENT_ALREADY_REGISTERED : 
        return constants.RECIPIENT_ALREADY_REGISTERED_STATUS             
    else:
        return constants.RECIPIENT_VERIFICATION_FAILED_STATUS
   

def get_basic_details(result_text,status):
    print "in basic details"
    result = {}
    result['status']=status
    if status != constants.UNKNOWN_STATUS:
        response = str(json.loads(result_text)['message'])
        print response
    else:
        response = result_text    
    result['responseText'] =get_formatted_response(response)
    return result