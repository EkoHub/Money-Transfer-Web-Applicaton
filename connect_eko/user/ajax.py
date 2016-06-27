#copyright @ Eko India Financial Service Pvt. Ltd.
'''
Modified on JUN 14, 2016

@author: siddharth
'''
import logging
# Get an instance of a logger
logger = logging.getLogger(__name__)
from django.utils import simplejson
from dajaxice.decorators import dajaxice_register
from user import module_user

# For agent type of the user entered 
@dajaxice_register
def get_agent_type_for_user(request, user_id):
    result = module_user.get_agent_type_for_user(int(user_id.replace(",", "")))
    return simplejson.dumps(result)

# For fetching the user info    
@dajaxice_register
def fetch_user_info(request, mobile_number, signature):
    result = module_user.fetch_user_info(mobile_number, signature)
    return simplejson.dumps(result)

# For updating the user info
@dajaxice_register
def update_user_info(request, mobile_number, name, code, type, prev_mobile_number):
    result = module_user.handle_user_account(mobile_number, name, code, type, prev_mobile_number)
    return simplejson.dumps(result)

# For setting the password
@dajaxice_register
def set_password(request, mobile_number, password1, password2):
    result = module_user.set_password(mobile_number, password1, password2)
    return simplejson.dumps(result)
    