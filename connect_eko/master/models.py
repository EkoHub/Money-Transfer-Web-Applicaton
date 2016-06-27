#copyright @ Eko India Financial Service Pvt. Ltd.
from django.db import models

# Create your models here.

# Master list of all banks
class Bank(models.Model):
    name = models.CharField(max_length=255)
    descr = models.CharField(max_length=100)
    is_active = models.BooleanField(default=False)
    short_name = models.CharField(max_length=10)

    def __unicode__(self):
        return str(self.name)
    

    
# Stores all the agent types supported in the system (CSP, SCSP, FoS etc)
class Agent_Type(models.Model):
    name = models.CharField(max_length=15)
    descr = models.CharField(max_length=100)
    
    def __unicode__(self):
        return str(self.name)




# Cellnumber types for users
class Cellnumber_Type(models.Model):
    name = models.CharField(max_length=15)
    descr = models.CharField(max_length=100)
    is_active = models.BooleanField(default=True)

    def __unicode__(self):
        return (str(self.name)).decode('unicode-escape')
    

#Stores all transaction types
class Transaction_Type(models.Model):
    name = models.CharField(max_length = 50)
    description = models.CharField(max_length = 250)
    display_name = models.CharField(max_length = 50, blank = True, null = True)
    short_code = models.CharField(max_length = 20, blank = True, null = True)
    display_color = models.CharField(max_length = 10, blank = True, null = True)

    def __unicode__(self):
        return str(self.name)
    

#Transaction type and bank mapping
class Bank_Transaction_Mapping(models.Model):
    tx_type = models.ForeignKey(Transaction_Type)
    bank = models.ForeignKey(Bank)
    reference_tx_type = models.IntegerField(blank = False, null = False, default = 0)
    commission_flag = models.BooleanField(default=False)



class Bank_Detail(models.Model):
    bank = models.ForeignKey(Bank)
    identifier = models.CharField(max_length = 10, default = None, null = True)
    account_number_length = models.IntegerField(default = None, null = True)
    account_number_validate_flag = models.BooleanField(default = False, null = False)
    ifsc_prefix = models.CharField(max_length = 10, default = None, null = True)
    ifsc_suffix_length = models.IntegerField(default = None, null = True)
    ifsc_autoconstruct_flag = models.BooleanField(default = False, null = False)
    neft_allowed_flag = models.BooleanField(default = True, null = False)
    imps_allowed_flag = models.BooleanField(default = False, null = False)
    frequency_order = models.IntegerField(default = 1, null = True)
    
    
  
# Stores all the agent types supported in the system (CSP, SCSP, FoS etc)
class User_Type(models.Model):
    name = models.CharField(max_length=15)
    descr = models.CharField(max_length=100)
    
    def __unicode__(self):
        return str(self.name)

