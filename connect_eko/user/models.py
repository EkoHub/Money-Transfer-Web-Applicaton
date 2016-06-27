#copyright @ Eko India Financial Service Pvt. Ltd.
# System import
from django.db import models
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.conf import settings
from actstream import action
from django.db import transaction
from django.contrib.contenttypes.models import ContentType
from django.contrib.contenttypes import generic

# Custom import
from django.contrib.auth.models import User
from master.models import  Cellnumber_Type, User_Type

# Classes begin here

           
# Capture the personal details of each user
class Personal_Detail(models.Model):
    user = models.ForeignKey(User)
    marital_status = models.CharField(max_length = 20, default = None)
    edu_qual = models.CharField(max_length = 30, default = None)
    citizenship = models.CharField(max_length = 30, default = None)
    handicapped_detail = models.CharField(max_length = 50, default = None)
    gender = models.CharField(max_length = 10, default = None)
    dob = models.DateField(auto_now = False, default = None)
    num_children = models.IntegerField(blank = True, null = True, default = None)
    pan_number = models.CharField(max_length = 15, default = None)
    service_tax_number = models.CharField(max_length = 20, default = None)
    census_code = models.CharField(max_length = 15, default = None)
    
    def __unicode__(self):
        return str(self.name)

# Capture all cell numbers for user
class Cellnumber_Detail(models.Model):
    user = models.ForeignKey(User)
    cellnumber = models.CharField(max_length = 13)
    cellnumber_type = models.ForeignKey(Cellnumber_Type)
    is_active = models.BooleanField(default = True)
    #created_at = models.DateTimeField(blank = False, null = False, auto_now_add = True)
    #updated_at = models.DateTimeField(blank = True, null = True, default = None)
    
    def __unicode__(self):
        return (str(self.cellnumber)+" : "+str(self.user)).decode('unicode-escape')

class Type(models.Model):
    user = models.ForeignKey(User, blank = True, null = True)
    user_type = models.ForeignKey(User_Type)
    
    def __unicode__(self):
        return str(self.name)

class Login_Data(models.Model):
    user = models.ForeignKey(User)
    failed_login_attempts = models.IntegerField(blank = True, null = True)
    last_failed_login_time = models.DateTimeField(blank = True, null = True)
    logged_in_flag = models.BooleanField(default = False)
    active_session_key = models.CharField(max_length = 100, null = True)
    account_locked_flag = models.BooleanField(default = False)

