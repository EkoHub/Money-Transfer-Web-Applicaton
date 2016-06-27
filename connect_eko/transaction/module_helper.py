#copyright @ Eko India Financial Service Pvt. Ltd.
'''
Created on Jun 19, 2016

@author: alankar
'''

from master.models import Bank_Detail, Bank
from transaction.models import Bank_Mapping
import traceback

#To get the bank details for any particular ID

def get_detail_for_bank(id):
    result = {}
    try:
        bank_detail_obj = Bank_Detail.objects.filter(bank_id = id)[0]
        result['account_num_length'] = bank_detail_obj.account_number_length
        if bank_detail_obj.ifsc_prefix is not None:
            result['ifsc_lookup'] = 'ENABLED'
            result['ifsc_prefix'] = bank_detail_obj.ifsc_prefix
            result['ifsc_suffix_length'] = bank_detail_obj.ifsc_suffix_length
        else:
            result['ifsc_lookup'] = 'DISABLED'       
        
    except:
        print 'Error fetching bank details for id = ' + str(id)
        print traceback.print_exc()
    
    return result

def get_bank_detail_by_name(name):
    try:
        bank = Bank.objects.filter(name__contains = name)[0]
        return get_config_detail_for_bank(bank.id)
    except:
        print 'Error fetching bank info like text = ' + name
        print traceback.print_exc()
        return None
        

def get_config_detail_for_bank(id):
    result = {}
    try:
        bank_detail_obj = Bank_Detail.objects.filter(bank_id = id)[0]
        result['neft_flag'] = int(bank_detail_obj.neft_allowed_flag)
        result['imps_flag'] = int(bank_detail_obj.imps_allowed_flag)               
        
    except:
        print 'Error fetching bank details for id = ' + str(id)
        print traceback.print_exc()
        result['neft_flag'] = 0
        result['imps_flag'] = 0 
    
    return result



def prepare_extra_transaction_param(transaction_type, bank_id):
    param_list = []
    param_sms = get_agent_sms_param(transaction_type, bank_id)
    if param_sms != None:
        param_list.append(param_sms)
        
    return param_list
    
    
def get_agent_sms_param(transaction_type, bank_id):
    try:
        transaction_bank_mapping_obj = Bank_Mapping.objects.get(transaction_type = transaction_type, bank_id = bank_id)
        if transaction_bank_mapping_obj.agent_sms_flag == 0:
            param = {}
            param['key'] = 'sendSms'
            param['value'] = 1
            return param
        else:
            return None
    except:
        print  'Exception in getting SMS param for bank_id = ' + str(bank_id) + ' and transaction_type_id = ' + str(transaction_type.id)
        print traceback.print_exc()
        return None
     
    
    