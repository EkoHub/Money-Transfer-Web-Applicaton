#copyright @ Eko India Financial Service Pvt. Ltd.
from django.db import models
from django.contrib.auth.models import User
from agent.models import Agent
from master.models import Bank, Transaction_Type

# Create your models here.

   
class Bank_Mapping(models.Model):
    transaction_type = models.ForeignKey(Transaction_Type)
    bank = models.ForeignKey(Bank)
    agent_sms_flag = models.BooleanField(default = True, null = False)
    active_flag = models.BooleanField(default = True, null = False)
    
    
class Request_Log(models.Model):
    user = models.ForeignKey(User, default = None, null = True)
    agent = models.ForeignKey(Agent, default = None, null = True)
    bank = models.ForeignKey(Bank, default = None, null = True)
    transaction_type = models.ForeignKey(Transaction_Type, default = None, null = True)
    origination_address = models.DecimalField(max_digits = 15, decimal_places = 0)
    request_text = models.CharField(max_length = 100)    
    request_timestamp = models.DateTimeField(default = None, auto_now = False, auto_now_add = False, null = True)       
    connect_tid = models.DecimalField(max_digits = 30, decimal_places = 0, default = None, null = True)
    
    def __unicode__(self):
        return str(self.id)+" : "+str(self.transaction_type)
    
class Response_Log(models.Model):
    request_log = models.ForeignKey(Request_Log)
    origination_address = models.DecimalField(max_digits = 15, decimal_places = 0)
    response = models.CharField(max_length = 500, null = True, blank = True)
    response_timestamp = models.DateTimeField(default = None, auto_now = False, auto_now_add = False, null = True) 
    
