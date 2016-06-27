#copyright @ Eko India Financial Service Pvt. Ltd.
'''
Created  on Jun 8 2016

@author: alankar
'''

import traceback
from master import constants
from master.models import Transaction_Type
from transaction import module_switchcaller, module_helper,module_responsehandler_new,module_apicaller
import datetime,json
from connect_eko.settings import api_url,headers

# For the money transfer through ICICI For this 'Send Money' API is used
def moneytransfer_icici(user, agent, dialer, recipientAccountCode, senderNumber, amount, transactionMode, ifscTransaction):
    print "Starting ICICI money transfer"
    
    
    result = {}
    url = api_url + '/transactions'
    # preparing the data required for the transaction
    data={ 'recipient_id':recipientAccountCode,
            'amount':amount,
            'currency':'INR',
            'customer_id':senderNumber,
            'initiator_id':dialer,
            'client_ref_id':str(datetime.datetime.now().strftime("%I:%M:%S %p")),
            'state':1,
            # 'pintwin':okekey,
            'channel':transactionMode
      
            }
            
    request_type='POST'        
    params = {}

    # Obtaining the transaction type from the Transaction_Type table in the database
    transaction_type = Transaction_Type.objects.get(id = constants.TRXN_MONEY_TRANSFER)
    # Preparing the extra praameters required for making the logs
    extra_param = module_helper.prepare_extra_transaction_param(transaction_type, constants.BANK_ICICI)
    # API call is made through api_call function present in the module_apicaller
    result_text = module_apicaller.api_call(user, agent, transaction_type, dialer,request_type, url, params, data, headers,extra_param)
    # logs are added
    
    response = ''
    
    result['status'] = module_responsehandler_new.icici_moneytransfer_response(result_text)
    
    if result['status'] == constants.UNKNOWN_STATUS: # this is for the purpose if the response doesnot come from the API due to any reason
        response = result_text
    else:
        # if the 'status' is 'incorrect pin' then we have to show him the last okkey
        # we set the value of okkey in the result dictionary and send it to the html file in which it is shown on the frontend
        if result['status'] == constants.INCORRECT_PIN_STATUS:
            result['okekey'] = str(json.loads(result_text)['data']['last_used_okekey'])
            response = str(json.loads(result_text)['message'])
        elif result['status'] == constants.SUCCESS_DISP:
            # if the 'status' is 'success' the we have to show him the 'amount' and the 'transaction id'
            result['amount'] = str(json.loads(result_text)['data']['amount'])
            result['okekey'] = str(json.loads(result_text)['data']['last_used_okekey'])
            result['balance'] = str(json.loads(result_text)['data']['balance'])+'0'
            response = response = str(json.loads(result_text)['message'])+'\nTid: '+ str(json.loads(result_text)['data']['tid']) +'\nLast Okkey Used: ' + str(json.loads(result_text)['data']['last_used_okekey']) 
        else:
            response = str(json.loads(result_text)['message'])
            
        # we format the response through 'get_formatted_response' function 
    result['responseText'] = module_responsehandler_new.get_formatted_response(response)    
    result['timestamp'] = str(datetime.datetime.now().strftime("%I:%M:%S %p"))
    return result


# For finding the details related to any transaction using the tid value
# For this purpose 'Transaction Enquiry' API is used
def transaction_search_by_tid(user, agent, dialer, transactionId):
    print "String Transaction Enquary"
    print ('Transaction id: ',transactionId)
    
    result = {}
    url = api_url + '/transactions/' + str(transactionId)
    params = {'initiator_id':'mobile_number:'+str(dialer)}
    data = {}
    request_type = 'GET'

    transaction_type = Transaction_Type.objects.get(id = constants.TRXN_ENQ)
    extra_param = module_helper.prepare_extra_transaction_param(transaction_type, constants.BANK_ICICI)
    # Calling the api_call function and passing the necessary parameters 
    result_text = module_apicaller.api_call(user, agent, transaction_type, dialer,request_type, url, params, data, headers, extra_param)
    
    if 'status' not in result_text:
        response = result_text
    else:     
        result_text_json = json.loads(result_text)
        if result_text_json['response_type_id'] == 70:
            response = module_responsehandler_new.get_formatted_response_data(result_text_json['data'])

        elif result_text_json['response_type_id'] == 69:
            response = result_text_json['invalid_params']['tid']
        else:
            response = result_text_json['message']    
    result['responseText'] = module_responsehandler_new.get_formatted_response(response)
    return result


