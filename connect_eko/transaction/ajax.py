#copyright @ Eko India Financial Service Pvt. Ltd.
'''
Created on Jun 22, 2016

@author: siddharth
'''

import logging
# Get an instance of a logger
logger = logging.getLogger(__name__)


# Create your views here.
from django.shortcuts import render_to_response
from django.http import HttpResponse
from django.template import RequestContext
from agent.models import Agent,Transaction_Cellnumber
from master.constants import BANK_SBI, BANK_YBL, BANK_ICICI, AGENT_TYPE_RETAILER, AGENT_TYPE_ICSP, PPI
import traceback
from transaction import module_moneytransfer, module_customerenrolment, module_recipientregistration, module_misc_transaction, module_helper

import simplejson
from dajaxice.decorators import dajaxice_register
from user.models import Cellnumber_Detail
from master.models import Cellnumber_Type
from django.db.models import Q
from django.contrib.auth.decorators import login_required

import re


#####################################################################################################

## ICICI transaction related calls start here


@dajaxice_register
def customerenrolment_icici(request, senderNumber, senderName):
    try:
        if request.user.is_anonymous():
            return session_timeout_data()
        agent = get_transacting_agent(request.user)      
        cellnumber = get_transacting_cellnumber(request.user, agent)
        if agent.official_detail.bank.id == BANK_ICICI:
            result_data = module_customerenrolment.customerenrolment_icici(request.user, agent, cellnumber, senderNumber, senderName)
            return simplejson.dumps(result_data)
        else:
            return render_to_response('404.html')
        
    except:
        logger.error("unhandled exception: something went wrong with ajax call customerenrolment_icici")   
        print traceback.print_exc()


@dajaxice_register
def recipientInquiry_icici(request, senderNumber):
    try:
        if request.user.is_anonymous():
            return session_timeout_data()
        agent = get_transacting_agent(request.user)      
        cellnumber = get_transacting_cellnumber(request.user, agent)
        result_data = module_recipientregistration.recipientInquiry_icici(request.user, agent, cellnumber, senderNumber)
        return simplejson.dumps(result_data) 
           
    except:        
        print traceback.print_exc()
        
@dajaxice_register
def recipientregistration_icici(request, senderNumber, recipientAccountNo, recipientIfsc, bankId, recipientName, recipientMobile, recipientFound):
    try:
        print("Inside recipientregistration_icici()::Username::", request.user.username)
        if request.user.is_anonymous():
            return session_timeout_data()
        agent = get_transacting_agent(request.user)
        print("Inside recipientregistration_icici() getting agent::Username::", request.user.username)
        cellnumber = get_transacting_cellnumber(request.user, agent)
        print("Inside recipientregistration_icici() getting cellnumber::Username::",request.user.username)
        if agent.official_detail.bank.id == BANK_ICICI:
            if recipientFound == '1':
                if recipientName == '' or recipientName == None:
                    recipientName = str(request.session['found_recipient_data']['recipient_found'])
                if recipientIfsc == '' or recipientIfsc == None:
                    recipientIfsc = str(request.session['found_recipient_data']['ifsc_found'])  
            request.session['found_recipient_data'] = None
            result_data = module_recipientregistration.recipientregistration_icici(request.user, agent, cellnumber, senderNumber, recipientAccountNo, recipientIfsc, bankId, recipientName, recipientMobile)
            return simplejson.dumps(result_data)
        else:
            return render_to_response('404.html')
        
    except:        
        print traceback.print_exc()

#added by rohit lakshykar        
@dajaxice_register
def recipientVerifiaction_icici(request, senderNumber, recipientAccountNo, recipientIfsc, bankId, recipientFound):
    try:
        if request.user.is_anonymous():
            return session_timeout_data()
        agent = get_transacting_agent(request.user)      
        cellnumber = get_transacting_cellnumber(request.user, agent)
        if agent.official_detail.bank.id == BANK_ICICI:
            if recipientFound == '1':
                if recipientIfsc == '' or recipientIfsc == None:
                    recipientIfsc = str(request.session['found_recipient_data']['ifsc_found'])  
            request.session['found_recipient_data'] = None
            result_data = module_recipientregistration.recipientVerifiaction_icici(request.user, agent, cellnumber, senderNumber, recipientAccountNo, recipientIfsc, bankId)
            return simplejson.dumps(result_data)
        else:
            return render_to_response('404.html')
        
    except:        
        print traceback.print_exc()
        
@dajaxice_register
def recipient_individual_inquiry_icici(request, senderNumber, recipientAccountOrCode):     
    try:
        if request.user.is_anonymous():
            return session_timeout_data()
        
        if recipientAccountOrCode is None:
            print "Recipient code not found"
            return simplejson.dumps("Recipient code not found") 
    
        agent = get_transacting_agent(request.user)      
        cellnumber = get_transacting_cellnumber(request.user, agent)
        result_data = module_recipientregistration.recipient_idividual_inquiry_icici(request.user, agent, cellnumber, senderNumber, recipientAccountOrCode)
        return simplejson.dumps(result_data)      
    except:        
        logger.error("unhandled exception: something went wrong with ajax call recipient_individual_inquiry_ybl")        
        print traceback.print_exc()
        
        
@dajaxice_register
def moneytransfer_icici(request, senderNumber, recipientAccountCode, amount, transactionMode, ifscTransaction):    
    try:
        if request.user.is_anonymous():
            return session_timeout_data()
        print("Inside moneytransfer_icici()")
        agent = get_transacting_agent(request.user)
        print("Inside moneytransfer_icici()::fethcing agent::Username::", request.user.username)
        cellnumber = get_transacting_cellnumber(request.user, agent)
        print("Inside moneytransfer_icici()::fethcing cellnumber::Username::", request.user.username)
        if agent.official_detail.bank.id == BANK_ICICI:
            result_data = module_moneytransfer.moneytransfer_icici(request.user, agent, cellnumber, recipientAccountCode, senderNumber, amount, transactionMode, ifscTransaction)
            return simplejson.dumps(result_data)        
        else:
            return render_to_response('404.html')
        
    except:        
        print traceback.print_exc()

## transaction related common tasks

#####################################################################################################

  

@dajaxice_register
def balance_inquiry(request):
    if request.user.is_anonymous():
            return session_timeout_data()
    print 'Request for balance inquiry'
    
    agent = get_transacting_agent(request.user)
    cellnumber = get_transacting_cellnumber(request.user, agent)
    result = module_misc_transaction.balance_inquiry(request.user, agent, cellnumber)    
    
    return simplejson.dumps(result)


@dajaxice_register
def get_bank_ifsc(request, id, accountNum):
    if request.user.is_anonymous():
            return session_timeout_data()
    print 'Request for IFSC for bank id = ' + str(id) + ' and account = ' + str(accountNum)
    result = module_helper.get_bank_ifsc(id, accountNum)    
    return simplejson.dumps(result)


@dajaxice_register
def get_bank_info(request, id):
    if request.user.is_anonymous():
            return session_timeout_data()
    print 'Request for bank info for bank id = ' + str(id)
    result = module_helper.get_detail_for_bank(id)    
    return simplejson.dumps(result)


@dajaxice_register
def get_existing_recipient_info(request, bankId, accountNum):
    if request.user.is_anonymous():
        return session_timeout_data()
    print 'Request for account number and bank lookup: ' + bankId + ', ' + accountNum
    agent = get_transacting_agent(request.user)
    cellnumber = get_transacting_cellnumber(request.user, agent)
    result = module_misc_transaction.account_number_lookup(request.user, agent, cellnumber, accountNum, bankId)
    
    if result['status'] == 'SUCCESS' and result['recipient_found'] != '' and result['ifsc_found'] != '':
        request.session['found_recipient_data'] = None
        request.session['found_recipient_data'] = result
        print 'EXISTING_RECIPIENT_FOUND'
        name = result['recipient_found']
        
        return simplejson.dumps({'status': 'EXISTING_RECIPIENT_FOUND', 'recipient': name, 'ifsc': result['ifsc_found']})
    else:
        print 'EXISTING_RECIPIENT_NOT_FOUND'
        return simplejson.dumps({'status': 'EXISTING_RECIPIENT_NOT_FOUND'})
    
     
@dajaxice_register
def unknown_transaction_inquiry(request, pending_id):
    if request.user.is_anonymous():
        return session_timeout_data()
    print 'Request for SoS'
    agent = get_transacting_agent(request.user)
    cellnumber = get_transacting_cellnumber(request.user, agent)      
    print pending_id  
    result = module_misc_transaction.unknown_status_inquiry(request.user, agent, cellnumber, pending_id)
    
    print result
    return simplejson.dumps(result)

@dajaxice_register
def booklet_registration(request, booklet, key1, key2):
    if request.user.is_anonymous():
        return session_timeout_data()
    print 'Request for Booklet Registration'
    agent = get_transacting_agent(request.user)
    cellnumber = get_transacting_cellnumber(request.user, agent)      
    print booklet + ', ' + key1 + ', ' + key2  
    result = module_misc_transaction.booklet_registration(request.user, agent, cellnumber, booklet, key1, key2)
    print result
    return simplejson.dumps(result)


@dajaxice_register
def booklet_inquiry(request):
    if request.user.is_anonymous():
        return session_timeout_data()
    print 'Request for Booklet Inquiry'
    agent = get_transacting_agent(request.user)
    cellnumber = get_transacting_cellnumber(request.user, agent)      
    result = module_misc_transaction.booklet_inquiry(request.user, agent, cellnumber)
    print result
    return simplejson.dumps(result)


@dajaxice_register
def bank_config_inquiry(request, bankId):
    if request.user.is_anonymous():
        return session_timeout_data()
    print 'Request for Bank Config Inquiry'
    agent = get_transacting_agent(request.user)
    cellnumber = get_transacting_cellnumber(request.user, agent)      
    result = module_misc_transaction.bank_config_inquiry(request.user, agent, cellnumber, bankId)
    print result
    return simplejson.dumps(result)

def get_transacting_agent(request_user):
    print request_user
    #here agent_type_retailer is hardcoded.
    #change needed : 1. fetch agents based on permission to transact not by type
    #change needed : 1. fetch all agents who can transact, not only one. Let the user choose which one to use
    return Agent.objects.filter(Q(user = request_user) & (Q(agent_type_id = AGENT_TYPE_RETAILER) | Q(agent_type_id = AGENT_TYPE_ICSP)))[0]

def get_transacting_cellnumber(request_user, request_agent):
    try:
        if request_agent.prime_cell is not None:
            cell = request_agent.prime_cell.cellnumber    
        else:
            cell = Transaction_Cellnumber.objects.filter(agent=request_agent)[0].cell_number.cellnumber
    except:
        cell = None
    return cell
    

def session_timeout_data():
    bundle = {}
    bundle['status'] = 'SESSION_TIMEOUT'
    bundle['responseText'] = 'Your session timed-out. Please login again and proceed.'
    return simplejson.dumps(bundle)

@dajaxice_register
def post_agreement_consent(request):
    print('Inside post_agreement_consent() function')
    try:
        if request.user.is_anonymous():
            return session_timeout_data()
        agent = get_transacting_agent(request.user)
        cellnumber = get_transacting_cellnumber(request.user, agent)
        if agent.official_detail.bank.id == PPI or agent.official_detail.bank.id == BANK_ICICI:
            result_data = module_misc_transaction.post_agreement_consent(request.user, agent, cellnumber)
            return simplejson.dumps(result_data)
        else:
            return render_to_response('404.html')
    except:
        logger.error("unhandled exception: something went wrong with ajax call post_agreement_consent") 
        print traceback.print_exc()

@dajaxice_register
def senderInquiry_ppi(request, senderNumber):
    print('Inside senderInquiry_ppi() function')
    
    try:
        if request.user.is_anonymous():
            return session_timeout_data()
        agent = get_transacting_agent(request.user)
        cellnumber = get_transacting_cellnumber(request.user, agent)
        result_data = module_customerenrolment.senderInquiry_ppi(request.user, agent, cellnumber, senderNumber)
        return simplejson.dumps(result_data)
        
    except:
        logger.error("unhandled exception: something went wrong with ajax call senderInquiry_ppi")
        print traceback.print_exc()



@dajaxice_register
def customerenrolmentotpverification_ppi(request, senderNumber, otp):
    print('Inside customerenrolmentotpverification_ppi() function')
    try:
        if request.user.is_anonymous():
            return session_timeout_data()
        agent = get_transacting_agent(request.user)
        cellnumber = get_transacting_cellnumber(request.user, agent)
        #if agent.official_detail.bank.id == PPI: #comment by rohit lakshykar
        if agent.official_detail.bank.id == BANK_ICICI:
            result_data = module_customerenrolment.customerenrolmentotpverification_ppi(request.user, agent, cellnumber, senderNumber, otp)
            return simplejson.dumps(result_data)
        else:
            return render_to_response('404.html')
        
    except:  
        logger.error("unhandled exception: something went wrong with ajax call customerenrolmentotpverification_ppi")
        print traceback.print_exc()


@dajaxice_register
def customerenrolmentresendotp_ppi(request, senderNumber):
    print('Inside customerenrolmentresendotp_ppi() function')
    try:
        if request.user.is_anonymous():
            return session_timeout_data()
        agent = get_transacting_agent(request.user)
        cellnumber = get_transacting_cellnumber(request.user, agent)
        #if agent.official_detail.bank.id == PPI: #comment by rohit lakshykar
        if agent.official_detail.bank.id == BANK_ICICI:
            result_data = module_customerenrolment.customerenrolmentresendotp_ppi(request.user, agent, cellnumber, senderNumber)
            return simplejson.dumps(result_data)
        else:
            return render_to_response('404.html')
        
    except:  
        logger.error("unhandled exception: something went wrong with ajax call customerenrolmentresendotp_ppi")
        print traceback.print_exc()

@dajaxice_register
def transaction_search_by_tid(request,transactionId):
    print('Inside transaction_search_by_tid() function')
    try:
        if request.user.is_anonymous():
            return session_timeout_data()
        agent = get_transacting_agent(request.user)      
        cellnumber = get_transacting_cellnumber(request.user, agent)
        if agent.official_detail.bank.id == BANK_ICICI:
            result_data = module_moneytransfer.transaction_search_by_tid(request.user, agent, cellnumber, transactionId)
            return simplejson.dumps(result_data)
        else:
            return render_to_response('404.html')
        
    except:
        logger.error("unhandled exception: something went wrong with ajax call customerenrolment_icici")   
        print traceback.print_exc()
    