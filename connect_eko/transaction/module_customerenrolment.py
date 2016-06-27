#copyright @ Eko India Financial Service Pvt. Ltd.
'''
Created on Jun 8 2016

@author: siddharth jandial
this module is for customer enrolment and is using the customer related APIs
'''

import traceback
from master import constants
from master.models import Transaction_Type
from transaction import module_switchcaller, module_helper,module_apicaller,module_responsehandler_new
from reportlab.lib.colors import papayawhip
import json
from connect_eko.settings import api_url,headers

# api_url and the headers are present in the settings.py

#*********************************** for icici agent************************************************************

def customerenrolment_icici(user, agent, dialer, senderMobile, senderName): # for the customer enrolemt
    print "Starting ICICI customer enrolment"   
    # for customer enrolment "create customer API is used   
    result = {}
    # data contains the additional information required
    data = {'name':senderName,'initiator_id':dialer}
    # url is created for the create customer api
    url = api_url+'/customers/mobile_number:'+str(senderMobile)
    params = {}
    # put request is used in this api call
    request_type = "PUT"

    # obtain the transaction type from the Transaction_Type table in the database
    transaction_type = Transaction_Type.objects.get(id = constants.TRXN_SENDER_ENROLMENT)
    extra_param = module_helper.prepare_extra_transaction_param(transaction_type, constants.BANK_ICICI)
    #result text store the data returned from the api 
    result_text = module_apicaller.api_call(user, agent, transaction_type, dialer,request_type, url, params, data, headers,extra_param)
    # obtaining the status from the responsehandler_new
    status = module_responsehandler_new.icici_enrolment_response(result_text)

    result=module_responsehandler_new.get_basic_details(result_text, status)
    # return the result to the html file  
    return result

# This function uses the "get customer" API and is used for both the ppi and icici
def senderInquiry_ppi(user, agent, dialer, senderNumber):
    print "Starting PPI sender inquiry"
    
    request_text = senderNumber
    url = api_url+'/customers/mobile_number:'+str(request_text) # required url
    params={'initiator_id':dialer}
    data = {}
    request_type = "GET"

    transaction_type = Transaction_Type.objects.get(id = constants.TRXN_SENDER_INQUIRY)
    extra_param = module_helper.prepare_extra_transaction_param(transaction_type, constants.BANK_ICICI)
    result_text = module_apicaller.api_call(user, agent, transaction_type, dialer,request_type, url, params, data, headers,extra_param)
    result = module_responsehandler_new.extract_response_and_other_config(result_text)
    return result



# here "verify customer" API is used 
def customerenrolmentotpverification_ppi(user, agent, dialer, senderMobile, otp):
    print "Starting PPI customer enrolment OTP verification"
    
    result = {}
    data = {'id':senderMobile,'initiator_id':dialer,'id_type':'mobile_number',}
    url = api_url+'/customers/verification/otp:'+str(otp)
    params = {}
    request_type = "PUT"

    transaction_type = Transaction_Type.objects.get(id = constants.TRXN_SENDER_ENROLMENT_VERIFIC)
    extra_param = module_helper.prepare_extra_transaction_param(transaction_type, constants.BANK_ICICI) 
    result_text = module_apicaller.api_call(user, agent, transaction_type, dialer, request_type, url, params, data, headers, extra_param)
    status=module_responsehandler_new.ppi_customerotpverification_response(result_text)
    result=module_responsehandler_new.get_basic_details(result_text, status)
    return result

#here "resend otp" API is called 
def customerenrolmentresendotp_ppi(user, agent, dialer, senderMobile):
    print "Starting PPI customer enrolment resend OTP request"
    
    result = {}
    data = {'initiator_id':dialer,}
    url = api_url+'/customers/mobile_number:'+str(senderMobile)+'/otp'
    request_type = "POST"
    params = {}

    transaction_type = Transaction_Type.objects.get(id = constants.TRXN_SENDER_ENROLMENT_RESEND_OTP)
    extra_param = module_helper.prepare_extra_transaction_param(transaction_type, constants.BANK_ICICI)
    result_text = module_apicaller.api_call(user, agent, transaction_type, dialer,request_type, url, params, data, headers, extra_param)
    if 'status' not in result_text:
        response = result_text
    else:
        response = str(json.loads(result_text)['message'])    
    result['responseText'] = module_responsehandler_new.get_formatted_response(response)
        
    return result
