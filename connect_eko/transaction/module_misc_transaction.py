#copyright @ Eko India Financial Service Pvt. Ltd.
'''
Created on Jun 8 2016

@author: surya teja
'''

import traceback,json
from master import constants
from master.models import Transaction_Type, Bank_Detail
from transaction import module_switchcaller, module_helper,module_apicaller,module_responsehandler_new
from transaction.models import Request_Log, Response_Log
import datetime
from xml.dom import minidom
from connect_eko.settings import api_url,headers

# This function fetch the balance details of the agent
def balance_inquiry(user, agent, dialer):
    print 'Starting balance inquiry'

    result = {}
    transaction_type = Transaction_Type.objects.get(id = constants.TRXN_BALANCE_INQUIRY)
    extra_param = module_helper.prepare_extra_transaction_param(transaction_type, agent.official_detail.bank.id)
    if agent.official_detail.bank.id == constants.BANK_ICICI:
        result['bank'] = 'Eko'
    elif agent.official_detail.bank.id == constants.PPI:
        result['bank'] = 'Eko'
    else:
        result['bank'] = ''
    result_text = module_switchcaller.switch_caller(user, agent, transaction_type, dialer, '123', extra_param)

    result['status'] = module_responsehandler_new.balance_inquiry_response(result_text)
    result['timestamp'] = str(datetime.datetime.now().strftime("%I:%M:%S %p"))

    if result['status'] == constants.SUCCESS_DISP:
        print 'Parsing balance inquiry response'
        for line in result_text.splitlines():
            if "bal:rs" in line.lower():
                result['balance'] = line[7:]
            if "last okekey" in line.lower():
                result['signature'] = line[12:]
    else:
        pass

    return result

#This function looks for the account number and getting the details
def account_number_lookup(user, agent, dialer, account_number, bank_id):
    result = {}
    transaction_type = Transaction_Type.objects.get(id = constants.TRXN_ACCOUNT_NUMBER_LOOKUP)
    bank_identifier = Bank_Detail.objects.get(bank_id = bank_id).identifier
    request_text = '837*' + str(account_number) + '*' + str(bank_identifier) + '*ABCXYZ'
    
    extra_param = module_helper.prepare_extra_transaction_param(transaction_type, agent.official_detail.bank.id)
    result_text = module_switchcaller.switch_caller(user, agent, transaction_type, dialer, request_text, extra_param)
    result['status'] = module_responsehandler_new.account_number_lookup_response(result_text)
    
    if result['status'] == constants.SUCCESS_DISP:
        resp = minidom.parseString(result_text)
        error = resp.getElementsByTagName('errors')
        ifsc_code = resp.getElementsByTagName('ifsc_code')
        name_list = resp.getElementsByTagName('name')
        if len(error) > 0:
            
            result['recipient_found'] = ''
            result['ifsc_found'] = ''
        elif len(ifsc_code) > 0 and len(name_list) > 0:
            
            result['recipient_found'] = name_list[0].childNodes[0].nodeValue
            result['ifsc_found'] = ifsc_code[0].childNodes[0].nodeValue
    else:
        result['recipient_found'] = ''
        result['ifsc_found'] = ''

    return result


def unknown_status_inquiry(user, agent, dialer, pending_id):
    print 'Starting transaction SoS Inquiry'

    result = {}
    transaction_type = Transaction_Type.objects.get(id = constants.TRXN_SOS_INQUIRY)

    log_obj = Request_Log.objects.get(id = pending_id)
    response_log_obj = Response_Log.objects.get(request_log = log_obj)

    request_text = 'sos*' + str(log_obj.connect_tid)
    extra_param = module_helper.prepare_extra_transaction_param(transaction_type, agent.official_detail.bank.id)
    result_text = module_switchcaller.switch_caller(user, agent, transaction_type, dialer, request_text, extra_param)
    result['status'] = module_responsehandler_new.sos_inquiry_response(result_text)
    result['pending_id'] = pending_id

    if result['status'] == constants.SOS_RESPONSE_NOT_AVAILABLE_STATUS:
        response_log_obj.response = 'Transaction Failed'
        response_log_obj.response_timestamp = datetime.datetime.now()
        response_log_obj.save(False, True, None)
        result['response_obtained'] = 'Transaction Failed'
    elif result['status'] == constants.SOS_RESPONSE_AVAILABLE_STATUS:
        response_log_obj.response = result_text[4:]
        response_log_obj.response_timestamp = datetime.datetime.now()
        response_log_obj.save(False, True, None)
        result['response_obtained'] = result_text[4:]
    else:
        #do nothing
        pass

    return result

#For the registration of the booklet
def booklet_registration(user, agent, dialer, booklet, key1, key2):
    print 'Starting booklet registration'

    result = {}
    transaction_type = Transaction_Type.objects.get(id = constants.TRXN_BOOKLET_REGISTRATION)
    extra_param = module_helper.prepare_extra_transaction_param(transaction_type, agent.official_detail.bank.id)
    request_text = booklet + '*' + key1 + '*' + key2
    result_text = module_switchcaller.switch_caller(user, agent, transaction_type, dialer, request_text, extra_param)

    result['status'] = module_responsehandler_new.booklet_registration_response(result_text)
    print result['status']

    return result

# For the booklet inquiry for getting the details like last okkey uesd etc
def booklet_inquiry(user, agent, dialer):
    print 'Starting booklet inquiry'

    result = {}
    transaction_type = Transaction_Type.objects.get(id = constants.TRXN_BOOKLET_INQUIRY)
    extra_param = module_helper.prepare_extra_transaction_param(transaction_type, agent.official_detail.bank.id)
    result_text = module_switchcaller.switch_caller(user, agent, transaction_type, dialer, 'okekeyinfo', extra_param)

    result['status'] = module_responsehandler_new.booklet_inquiry_response(result_text)
    if result['status'] == constants.BOOKLET_INQUIRY_SUCCESS_STATUS:
        line_list = result_text.split('\n')
        result['booklet_number'] = line_list[0].split('\r')[0].split(':')[1]
        result['signature_count'] = line_list[1].split('\r')[0].split(':')[1]
        result['last_used'] = line_list[2].split('\r')[0].split(':')[1]

    return result

#For bank configuration inquiry and 'Get bank detail' API is called in it
def bank_config_inquiry(user, agent, dialer, bank_id):
    print 'Starting bank config inquiry'
    result = {}

    transaction_type = Transaction_Type.objects.get(id = constants.TRXN_BANK_CONFIG_INQUIRY)
    bank_identifier = Bank_Detail.objects.get(bank_id = bank_id).identifier
    url = api_url + '/banks'
    data = {}
    params = {'bank_code':bank_identifier,'initiator_id':"mobile_number:"+str(dialer)}
    request_type = 'GET'

    extra_param = module_helper.prepare_extra_transaction_param(transaction_type, agent.official_detail.bank.id)
    result_text = module_apicaller.api_call(user, agent, transaction_type, dialer,request_type, url, params, data, headers, extra_param)
    result['status'] = module_responsehandler_new.bank_config_inquiry_response(result_text)
    
    # FRom ifsc status and isverification flag we can show the next form to the user
    if result['status'] == constants.BANK_CONFIG_INQUIRY_SUCCESS_STATUS:
        response = str(json.loads(result_text)['message']) 
        result['ifsc_status'] = json.loads(result_text)['data']['ifsc_status']
        result['isverificationavailable'] = json.loads(result_text)['data']['isverificationavailable']
    else:
        
        response = result_text
    result['responseText'] = module_responsehandler_new.get_formatted_response(response)        

    return result

def post_agreement_consent(user, agent, dialer):
    print 'Starting post_agreement_consent'

    result = {}
    transaction_type = Transaction_Type.objects.get(id = constants.TRXN_AGREEMENT_CONSENT)
    extra_param = module_helper.prepare_extra_transaction_param(transaction_type, agent.official_detail.bank.id)
    result_text = module_switchcaller.switch_caller(user, agent, transaction_type, dialer, '24733', extra_param)

    result['status'] = module_responsehandler_new.post_agreement_consent_response(result_text)
    result['timestamp'] = str(datetime.datetime.now().strftime("%I:%M:%S %p"))

    if result['status'] == constants.SUCCESS_DISP:
        print 'Agreement has been successfully signed'
    else:
        pass

    return result


