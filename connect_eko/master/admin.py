#copyright @ Eko India Financial Service Pvt. Ltd.
from django.contrib import admin
from master.models import Bank,Agent_Type, Cellnumber_Type, Transaction_Type, Bank_Transaction_Mapping, Bank_Detail

class Agent_TypeAdmin(admin.ModelAdmin):
    fieldsets = [
        ('Name', {'fields':['name']}),
        ('Parent ID', {'fields':['descr']}),
    ]
    list_display = ('id', 'name','descr')
    list_filter = ['name']
    #list_filter = ['parent_id']
    search_fields = ['id']


admin.site.register(Agent_Type,Agent_TypeAdmin)



class Cellnumber_TypeAdmin(admin.ModelAdmin):
    fieldsets = [
        ('Name',                   {'fields':['name']}),
        ('Description',            {'fields':['descr']}),
        ('Is active ?',            {'fields':['is_active']}),
    ]
    list_display = ('id', 'name','descr')
    list_filter = ['is_active']
    #list_filter = ['parent_id']
    search_fields = ['name']

admin.site.register(Cellnumber_Type,Cellnumber_TypeAdmin)

class Transaction_TypeAdmin(admin.ModelAdmin):
    fieldsets = [
        ('Name',                {'fields':['name']}),
        ('Description',         {'fields':['description']}),
    ]
    list_display = ('id', 'name','description')
    #list_filter = ['parent_id']
    search_fields = ['name','description']

admin.site.register(Transaction_Type, Transaction_TypeAdmin)

class Bank_Transaction_MappingAdmin(admin.ModelAdmin):
    fieldsets = [
        ('Transaction Type',      {'fields':['tx_type']}),
        ('Bank',                  {'fields':['bank']}),
        ('Commission Flag',       {'fields':['commission_flag']}),
    ]
    list_display = ('id', 'tx_type')
    list_filter = ['bank']
    search_fields = ['tx_type']

admin.site.register(Bank_Transaction_Mapping, Bank_Transaction_MappingAdmin)

class BankAdmin(admin.ModelAdmin):
    fieldsets = [
        ('Name',                   {'fields':['name']}),
        ('Description',            {'fields':['descr']}),
        ('Active (0-N, 1-Y)',            {'fields':['is_active']}),
    ]
    list_display = ('id', 'name','descr')
    search_fields = ['id', 'name']


class Bank_DetailAdmin(admin.ModelAdmin):
    fieldsets = [
        ('Bank', {'fields': ['bank']}),
        ('Bank Identifier', {'fields': ['identifier']}),
        ('Account Number Length', {'fields': ['account_number_length']}),
        ('Account Number Length Validation (0-N, 1-Y)', {'fields': ['account_number_validate_flag']}),
        ('IFSC Prefix', {'fields': ['ifsc_prefix']}),
        ('IFSC Suffix Length', {'fields': ['ifsc_suffix_length']}),
        ('IFSC Autoconstruct (0-N, 1-Y)', {'fields': ['ifsc_autoconstruct_flag']}),
        ('NEFT Allowed (0-N, 1-Y)', {'fields': ['neft_allowed_flag']}),
        ('IMPS Allowed (0-N, 1-Y)', {'fields': ['imps_allowed_flag']}),
    ]
    list_display = ('id', 'bank', 'identifier', 'account_number_length', 'ifsc_prefix', 'ifsc_autoconstruct_flag', 'imps_allowed_flag')
    search_fields = ['bank__name', 'identifier', 'ifsc_prefix']
    
admin.site.register(Bank_Detail, Bank_DetailAdmin)


