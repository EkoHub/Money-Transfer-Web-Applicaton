#copyright @ Eko India Financial Service Pvt. Ltd.
'''
Created on Jun 17, 2016

@author: kunal,tejja
'''


import logging

logger = logging.getLogger(__name__)

import requests, traceback,urllib2,json
from datetime import datetime
from transaction.models import Request_Log, Response_Log
from django.db import transaction
import time
from master import constants 



def switch_caller(user, agent, transaction_type, origination_address, request_text, extraParam):
    print "in switch caller"
    result = '' 
    log_obj = None
    result_to_log = None
    response_timestamp = None
    
    if origination_address is None:
        print "Origination address not found"  
        result = "Error - Transaction cellnumber not found"
        return result
    
    try:        
        switch_url = 'http://test.eko.co.in:25006/ekoswitchqa/cellrequest.do'
        payload = {'method': 'handle',
                   'originationAddress': origination_address, 
                   'requestText': request_text,
                   'source': 'CONNECT'
        }
        for param in extraParam:
            payload[param['key']] = param['value']
        
        request_timestamp = datetime.now()      
             
        connect_tid = None
        print transaction_type.id   
        
        if transaction_type.id != constants.TRXN_SOS_INQUIRY and transaction_type.id != constants.TRXN_BALANCE_INQUIRY:
            connect_tid = int('2165' + str(int(round(time.time() * 1000))))
            payload['deviceTID'] = connect_tid 
        
        log_obj = log_request(user, agent, transaction_type, origination_address, request_text, request_timestamp, connect_tid)
        
        r = requests.post(switch_url, params = payload, timeout = 90) 
        result = r.content
        result_to_log = result
        response_timestamp = datetime.now()
                                 
                             
    except requests.Timeout:
        logger.error("Request timeout")                 
        result = 'Request time-out' + get_custom_timeout_response(transaction_type)
        print traceback.print_exc()
    
    except:
        logger.error("Error contacting Eko switch")                 
        result = 'Error contacting Eko switch'
        print traceback.print_exc() 
        
    if log_obj is not None:
        log_response(log_obj, response_timestamp, result_to_log)
           
    return result


@transaction.commit_on_success(None)
def log_request(user, agent, transaction_type, origination_address, request_text, request_timestamp, connect_tid):
    logger.info("save transaction request in transaction_request_log")
    try:
        req_log_obj = Request_Log()
        req_log_obj.user = user
        req_log_obj.agent = agent
        if agent is not None and agent.official_detail is not None:
            req_log_obj.bank = agent.official_detail.bank
        else:
            req_log_obj.bank = None
        req_log_obj.transaction_type = transaction_type
        req_log_obj.origination_address = origination_address
        req_log_obj.request_text = request_text
        req_log_obj.request_timestamp = request_timestamp
        req_log_obj.connect_tid = connect_tid
        req_log_obj.save(True, False, None)        
        return req_log_obj
    except:
        logger.error("Error saving transaction_request_log object")    
        print traceback.print_exc()
        return None  
        #Maybe trigger email here to identify when log saving is throwing error 


@transaction.commit_on_success(None)
def log_response(req_log_obj, response_timestamp, response):
    logger.info("save transaction response in transaction_response_log")
    try:
        resp_log_obj = Response_Log()
        resp_log_obj.request_log = req_log_obj
        resp_log_obj.origination_address = req_log_obj.origination_address
        resp_log_obj.response = response
        resp_log_obj.response_timestamp = response_timestamp
        resp_log_obj.save(True, False, None)
        return resp_log_obj
    except:
        logger.error("Error saving transaction_response_log object")    
        print traceback.print_exc()
        return None  
        

def get_custom_timeout_response(transaction_type):
    return 'Please Retry'

