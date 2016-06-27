#copyright @ Eko India Financial Service Pvt. Ltd.
'''
Created on Jun 08, 2016

@author: siddharth
'''

import logging
logger = logging.getLogger(__name__)
import requests, traceback
from datetime import datetime
from transaction.models import Request_Log, Response_Log
from django.db import transaction
import time
from master import constants
from transaction.module_switchcaller import log_request,get_custom_timeout_response,log_response

def api_call(user, agent, transaction_type, origination_address,request_type, url, params, data, headers, extraParam):
    print "In api call"
    result = '' 
    log_obj = None
    result_to_log = None
    response_timestamp = None
    request_timestamp = datetime.now()      
             
    connect_tid = None
    
        
    if transaction_type.id != constants.TRXN_SOS_INQUIRY and transaction_type.id != constants.TRXN_BALANCE_INQUIRY:
        connect_tid = int('2165' + str(int(round(time.time() * 1000))))
         
    request_text = url + str(data) + str(params)    
    log_obj = log_request(user, agent, transaction_type, origination_address, request_text, request_timestamp, connect_tid)
    
    try:
        if request_type == "GET":
            r = requests.get(url,params=params,data = data, headers=headers,timeout = 90)
        elif request_type == "PUT":
            r = requests.put(url,params=params,data = data, headers = headers, timeout = 90)
        elif request_type == "POST":
            r = requests.post(url,params=params,data = data, headers = headers, timeout = 90)
        else:
            r = requests.delete(url,params=params,data = data, headers = headers, timeout = 90)            
        result = r.content
        
    except requests.Timeout:
        logger.error("Request timeout")
        result = 'Request time-out' + get_custom_timeout_response(transaction_type)
        print traceback.print_exc()

    except:
        logger.error("Error connecting the server")
        result = 'Error contacting the server'
        #print traceback.print_exc()
        
    if log_obj is not None:
        log_response(log_obj, response_timestamp, result_to_log)
           
    return result
