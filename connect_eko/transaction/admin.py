#copyright @ Eko India Financial Service Pvt. Ltd.
'''
Created on Jun 20, 2016

@author: siddharth
'''

from django.contrib import admin
from transaction.models import Bank_Mapping

class Bank_MappingAdmin(admin.ModelAdmin):
    fieldsets = [
        ('Transaction Type', {'fields':['transaction_type']}),
        ('Bank', {'fields':['bank']}),
        ('Agent SMS', {'fields':['agent_sms_flag']}),
        ('Active', {'fields':['active_flag']}),
    ]
    list_display = ('id', 'transaction_type','bank', 'agent_sms_flag')
    #list_filter = ['transaction_type__name', 'bank__name']
    search_fields = ['transaction_type__name', 'bank__name']


admin.site.register(Bank_Mapping, Bank_MappingAdmin)