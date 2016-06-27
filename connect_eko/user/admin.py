#copyright @ Eko India Financial Service Pvt. Ltd.
# All the models are registered here
from django.contrib import admin
from user.models import Cellnumber_Detail,Login_Data



class Cellnumber_DetailAdmin(admin.ModelAdmin):
    fieldsets = [
        ('User',     {'fields':['user']}),
        ('cellnumber', {'fields':['cellnumber']}),
        ('cellnumber_type', {'fields':['cellnumber_type']}),
        ('is_active', {'fields':['is_active']}),
        
    ]
    list_display = ('id', 'user', 'cellnumber', 'cellnumber_type','is_active')
    list_filter = ['cellnumber_type']
    #list_filter = ['parent_id']
    search_fields = ['cellnumber','user__username','user__first_name']

admin.site.register(Cellnumber_Detail,Cellnumber_DetailAdmin)




class Login_DataAdmin(admin.ModelAdmin):
    fieldsets = [
        ('User',     {'fields':['user']}),
        ('Failed Login Attempts',     {'fields':['failed_login_attempts']}),
        ('Last Failed Login Time',     {'fields':['last_failed_login_time']}),
        ('Logged In (0-N 1-Y)',     {'fields':['logged_in_flag']}),
        ('Active Session Key',     {'fields':['active_session_key']}),
        ('Account Locked (0-N 1-Y)',     {'fields':['account_locked_flag']}),
    ]
    
    list_display = ('id', 'user', 'failed_login_attempts', 'last_failed_login_time', 'logged_in_flag', 'account_locked_flag')
    search_fields = ['user__username']
    
admin.site.register(Login_Data, Login_DataAdmin)