#copyright @ Eko India Financial Service Pvt. Ltd.
# Create your views here.
from django.shortcuts import render_to_response
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse
from django.template import RequestContext
from agent.models import Agent
from transaction.models import Bank_Mapping
from master import constants
from master.models import Transaction_Type, Bank, Bank_Detail
import traceback
import ajax
from transaction import ajax
import datetime
from django.utils import simplejson
import json


# Agent Login Status.
@login_required(login_url='/login/')
def moneytransfer(request):    
    print("Inside agent::moneytransfer()",request.user.username)
    # Fetch bank detail for this user
    try: 
        
        bank_detail_list = Bank_Detail.objects.all().order_by('-frequency_order', 'bank__name')
        dataset = []
        for bank_detail in bank_detail_list:
            entry = {}
            if bank_detail.bank.name != 'PPI':
                entry['id'] = bank_detail.bank.id
                entry['name'] = bank_detail.bank.name
            
                if bank_detail.account_number_validate_flag == True:
                    entry['acc_num_length'] = bank_detail.account_number_length
                else:
                    entry['acc_num_length'] = '-1'
                    
                if bank_detail.ifsc_autoconstruct_flag == True and bank_detail.ifsc_prefix is not None and bank_detail.ifsc_suffix_length is not None:
                    entry['ifsc_prefix'] = bank_detail.ifsc_prefix
                    entry['ifsc_suffix_length'] = bank_detail.ifsc_suffix_length
                else:
                    entry['ifsc_prefix'] = ''
                    entry['ifsc_suffix_length'] = '-1'
                dataset.append(entry)
        
        agent = ajax.get_transacting_agent(request.user)
        
        if agent is None:
            return HttpResponse('Agent not found')
        
        elif agent.official_detail is None:
            return HttpResponse('Agent official details not found')
        
        elif agent.official_detail.bank is None:
            return HttpResponse('No bank listed for this agent official details')
        
        else:
            
            if agent.official_detail.bank.id == constants.BANK_ICICI:
                #Check if agent is permitted for technology for registration without IFSC
                #if request.user.has_perm('transaction.autoifsc_allowed'):
                print("Inside agent::moneytransfer() but before rendering page::icici_autoifsc.html",request.user.username)
                return render_to_response('moneytransfer/icici_autoifsc.html', RequestContext(request, {'agent_type': agent.agent_type.id, 'bank_detail_list': dataset}))
            
            else:
                return HttpResponse('No service for this bank yet.')
    except:
        print traceback.print_exc()
        return HttpResponse('You are not allowed to perform transactions')
    
