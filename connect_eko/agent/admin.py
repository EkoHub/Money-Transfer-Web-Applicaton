#copyright @ Eko India Financial Service Pvt. Ltd.
from django.contrib import admin
from agent.models import Agent,Official_Detail,Transaction_Cellnumber

class AgentAdmin(admin.ModelAdmin):
    fieldsets = [
        ('User', {'fields':['user']}),
        ('Agent Type', {'fields':['agent_type']}),
        ('Parent ID', {'fields':['parent']}),
        ('Primary Cell', {'fields':['prime_cell']}),
        
        ('Is active ?', {'fields':['is_active']}),
    ]
    list_display = ('id','user', 'agent_type','parent', 'is_active')
    list_filter = ['agent_type']
    #list_filter = ['parent_id']
    search_fields = ['user__username','user__first_name']


admin.site.register(Agent,AgentAdmin)

class Official_DetailAdmin(admin.ModelAdmin):
    fieldsets = [
        ('agent',{'fields':['agent']}),
        ('Bank', {'fields':['bank']}),
        ('CSPCODE', {'fields':['cspcode']}),
        ('Cyberplat ID', {'fields':['cyberplat_term_id']}),
        ('Tatkal allowed ?', {'fields':['is_tatkal_allowed']}),
        ('Blacklisted ?', {'fields':['is_blacklisted']}),
    ]
    list_display = ('agent','bank', 'cspcode','cyberplat_term_id', 'is_tatkal_allowed','is_blacklisted')
    list_filter = ['bank']
    
    search_fields = ['cspcode','agent__user__username','agent__user_first_name']


admin.site.register(Official_Detail,Official_DetailAdmin)

class Transaction_CellnumberAdmin(admin.ModelAdmin):
    fieldsets = [
        ('agent',{'fields':['agent']}),
        ('cell_number', {'fields':['cell_number']}),
        ('Is active ?', {'fields':['is_active']}),
    ]
    list_display = ('agent','cell_number','is_active')
    list_filter = ['agent']
    
    search_fields = ['agent']


admin.site.register(Transaction_Cellnumber,Transaction_CellnumberAdmin)


