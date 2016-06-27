#copyright @ Eko India Financial Service Pvt. Ltd.
'''
Created on Jun 15, 2016

@author: Kunal
This module is for the recipient and is using the recipient related APIs
'''
import logging
from string import strip
from actstream.views import respond
from operator import indexOf
# Get an instance of a logger
logger = logging.getLogger(__name__)

import traceback
from transaction import module_switchcaller, module_helper,module_apicaller,module_responsehandler_new
from master import constants
from master.models import Transaction_Type, Bank_Detail
import re,json
from connect_eko.settings import api_url,headers

   #**********************   FOR ICICI *****************************************************************************

def recipientInquiry_icici(user, agent, dialer, senderNumber):
    print "Starting ICICI recipient list inquiry"
    result = {}
    # Preparing the URL needed to make API Call with data,headers,and parameters.
    # Get All Recipients API is being used

    request_type = "GET"
    data = {}
    params = {'initiator_id':dialer}
    url = api_url+'/customers/mobile_number:'+str(senderNumber)+'/recipients'

    transaction_type = Transaction_Type.objects.get(id = constants.TRXN_REGISTERED_RECIPIENT_INQUIRY)
    extra_param = module_helper.prepare_extra_transaction_param(transaction_type, constants.BANK_ICICI)
    result_text = module_apicaller.api_call(user, agent, transaction_type, dialer, request_type, url, params, data, headers, extra_param)  
    recipient_list = []
    count = 0 
    sender_name = ""    
    sender_aadhaar = ""
    wallet_limit = ""
    remaining_wallet_limit=""
    bc_limit=""
    remaining_bc_limit=""
    aadhaar_status=""
    status = module_responsehandler_new.icici_recipient_list_inquiry_reponse(result_text)
    
    get_customer_url = api_url+'/customers/mobile_number:'+str(senderNumber)
    get_customer = module_apicaller.api_call(user, agent, transaction_type, dialer, request_type, get_customer_url, params, data, headers, extra_param)
    if 'status' in get_customer:
        get_customer_json = json.loads(get_customer)
        result['wallet_limit']= 10000
        result['remaining_wallet_limit'] = str(get_customer_json['data']['limit'][1]['remaining'])
        result['bc_limit']= 50000
        result['remaining_bc_limit'] = str(get_customer_json['data']['limit'][0]['remaining'])
        result['aadhaar_status']=aadhaar_status
        result['sender_name'] = str(get_customer_json['data']['name'])
        result['sender_aadhaar'] = ""
    else:
        response = get_customer
    if status != constants.UNKNOWN_STATUS:
            
        get_recipient_json = json.loads(result_text)

        if get_recipient_json['response_type_id'] == constants.NO_RECIPIENT:  #if response_type_id is 22 then there is no recipient
            result['recipients'] = recipient_list
            result['recipient_count'] = count  
        else:                                               # else recipients present and show the list of recipients
            result['recipients'] = get_recipient_json['data']['recipient_list']
            result['recipient_count'] = len(get_recipient_json['data']['recipient_list'])
    result['status'] = status
    if result['status'] != constants.UNKNOWN_STATUS :
        response = str(json.loads(result_text)['message']) 
    else:
        response = result_text    
    result['responseText'] = module_responsehandler_new.get_formatted_response(response)
    return result

# To register the new recipient.
def recipientregistration_icici(user, agent, dialer, senderNumber, recipientAccountNo, recipientIfsc, bankId, recipientName, recipientMobile):
    print "Starting ICICI recipient registration"

    result = {}
    # If customer doesnot enter IFSC code of the bank then it gets the code from database.
    
    if (recipientIfsc == None or recipientIfsc == '') and bankId != '-1':
        recipientIfsc = Bank_Detail.objects.get(bank_id = bankId).identifier
        
    # Preparing the URL needed to make API Call with data,headers,and parameters.
    # Add Recipient API is being used
    url = api_url + '/customers/mobile_number:' + str(senderNumber) +'/recipients/acc_ifsc:' + str(recipientAccountNo) + '_' + str(recipientIfsc).lower()
    request_type = 'PUT'
    params = {}
    data = {'recipient_name':recipientName,'initiator_id':dialer,'mobile':recipientMobile,'recipient_type':3}

    transaction_type = Transaction_Type.objects.get(id = constants.TRXN_RECIPIENT_REG)
    extra_param = module_helper.prepare_extra_transaction_param(transaction_type, constants.BANK_ICICI)
    result_text = module_apicaller.api_call(user, agent, transaction_type, dialer, request_type, url, params, data, headers, extra_param)
    #Using API Caller function to make request to server and get the response. 
    result['status'] = module_responsehandler_new.icici_recipient_registration_response(result_text)         
    
    if result['status'] != constants.UNKNOWN_STATUS: # for the purpose if the result hasn't come from the API then we show the whole result 
        response = str(json.loads(result_text)['message'])      # but if the result is come from the API then we show the message of the API response
        if 'Recipientid' in response:
            response = "Success Now select recipient and perform transaction"  
    else:
        response = result_text
    result['responseText'] = module_responsehandler_new.get_formatted_response(response)
                
    return result

# To verify a recipient, If it's bank account and details exist or not
def recipientVerifiaction_icici(user, agent, dialer, senderNumber, recipientAccountNo, recipientIfsc, bankId):
    print "Start ICICI recipient Verification"
    print bankId
    result = {}
    # If customer doesnot enter IFSC code of the bank then it gets the code from database.
    # Get Acc Name Info API is being used.
    if (recipientIfsc == None or recipientIfsc == '') and bankId != '-1':
        recipientIfsc = Bank_Detail.objects.get(bank_id = bankId).identifier
    # Preparing the URL needed to make API Call with data,headers,and parameters.
    url = api_url + '/banks/ifsc:' + str(recipientIfsc).lower() + '/accounts/' + str(recipientAccountNo)
    request_type = 'POST'
    data = {'initiator_id':dialer,'customer_id':senderNumber}
    params = {}

    transaction_type = Transaction_Type.objects.get(id = constants.TRXN_RECIPIENT_REG)
    extra_param = module_helper.prepare_extra_transaction_param(transaction_type, constants.BANK_ICICI)
    
    #Using API Caller function to make request to server and get the response.

    result_text = module_apicaller.api_call(user, agent, transaction_type, dialer,  request_type, url, params, data, headers, extra_param)
    result['status'] = module_responsehandler_new.recipient_verification_response(result_text)   
    if result['status'] != constants.UNKNOWN_STATUS :
        response = str(json.loads(result_text)['message']) 
    else:
        response = result_text    
    result['responseText'] = module_responsehandler_new.get_formatted_response(response)
    
    if result['status'] == 'RECIPIENT_VERIFIED':
        result['rcpt_name'] = json.loads(result_text)['data']['recipient_name']
        return result
    else:
        return result


# To check individual recipient.
def recipient_idividual_inquiry_icici(user, agent, dialer, senderNumber, account_code):
    print "Starting ICICI individual recipient inquiry"
    
    result = {}
    # Preparing the URL needed to make API Call with data,headers,and parameters.
    #Get Recipient API is being used.
    url = api_url + '/customers/mobile_number:' + str(senderNumber) + '/recipients/recipient_id:' +str(account_code)
    data = {}
    params = {'initiator_id':dialer}
    request_type = 'GET'
    response = ''
    
    transaction_type = Transaction_Type.objects.get(id = constants.TRXN_RECIPIENT_INDIVIDUAL_INQUIRY)
    extra_param = module_helper.prepare_extra_transaction_param(transaction_type, constants.BANK_ICICI)

    #Using API Caller function to make request to server and get the response.

    result_text = module_apicaller.api_call(user, agent, transaction_type, dialer, request_type, url,params, data, headers, extra_param)
    result['status'] = module_responsehandler_new.icici_recipient_individual_inquiry_reponse(result_text)  
    if result['status'] !=  constants.UNKNOWN_STATUS :
        response = 'Name: '+ str(json.loads(result_text)['data']['name']) +'\nAccount: ' + str(json.loads(result_text)['data']['account']) +'\nRecipient Id: '+str(json.loads(result_text)['data']['recipient_id']) 
    else:
        response = result_text    
    result['responseText'] = module_responsehandler_new.get_formatted_response(response)
    return result


