#copyright @ Eko India Financial Service Pvt. Ltd.
'''
Modified on Jun 16, 2013
@author: siddharth
'''

from django.core.mail import send_mail
from django.conf import settings
from agent.models import Agent, Official_Detail
from master.constants import AGENT_TYPE_RETAILER, AGENT_TYPE_DISTRIBUTOR, AGENT_TYPE_ICSP
from master.constants import BANK_SBI, BANK_ICICI, BANK_YBL, PPI
from master.constants import TRXN_USER_INFO_LOOKUP
from master.constants import CELLNUMBER_TYPE_PRIMARY
import traceback
from django.contrib.auth.models import User, Group
from user.models import Login_Data, Cellnumber_Detail, Cellnumber_Type
import datetime
from connect_eko import settings
from django.contrib.sessions.backends.db import Session
from transaction import module_switchcaller, module_helper, module_responsehandler_new
from master.models import Transaction_Type, Agent_Type, Bank


def register_new_detail(bundle, user, name , dob, mobile, parent_csp_code):
    mssg = "Request of change of the following details for username " + user.username 
    
    if name != None and name != '':
        mssg = mssg + "\nName = " + name
        
    if dob != None and dob != '':
        mssg = mssg + "\nDOB = " + dob
        
    if mobile != None and mobile != '':
        mssg = mssg + "\nMobile = " + mobile
        
    if parent_csp_code != None and parent_csp_code != '':
        mssg = mssg + "\nSCSP Code = " + parent_csp_code
    
    bundle.data['status'] = 'SUCCESS'
        
    print mssg
    send_mail('Sales Executive Profile Change', mssg, settings.DEFAULT_FROM_EMAIL,
    [settings.DEFAULT_ADMIN_EMAIL], fail_silently=False)
    
    return bundle


def get_agent_type_for_user(user_id):
    result = {}
    try:
        agent = Agent.objects.filter(user_id = user_id)
        if agent != None:
            if len(agent) > 1:
                result['status'] = 'FAILURE'
            elif len(agent) == 1:
                result['status'] = constants.SUCCESS_STATUS
                if agent[0].agent_type.id == AGENT_TYPE_RETAILER:
                    result['type'] = 'RETAILER'
                elif agent[0].agent_type.id == AGENT_TYPE_DISTRIBUTOR:
                    result['type'] = 'DISTRIBUTOR'
        else:
            result['status'] = 'NO_AGENT'
    except:
        result['status'] = 'FAILURE'
        traceback.print_exc()
        
    return result
            

def check_user_active_session(user):
    session_all = Session.objects.filter(expire_date__gt = datetime.datetime.now())
    for session in session_all:
        uid = session.get_decoded().get('_auth_user_id')        
        if uid is not None and uid == user.id:
            print 'Already logged in = ' + user.username
            return True
    return False


def user_login_status(username):
    try:
        user = User.objects.get(username = username)
        user_login_obj = Login_Data.objects.get(user = user)
        if user_login_obj.account_locked_flag == 1:
            return constants.ACCOUNt_LOCKED
        else:
            return 'ACCOUNT_ACTIVE'
    except User.DoesNotExist:
        return 'USER_DOES_NOT_EXIST'            
    except Login_Data.DoesNotExist:
        return 'ACCOUNT_ACTIVE_FIRST_LOGIN'

# To create (for the first time) or update the user login status info in user_login_data
def update_user_login_status(user, session_key):
    try:
        user_login_obj = Login_Data.objects.get(user = user)
        
        if user_login_obj.failed_login_attempts > 0:
            user_login_obj.failed_login_attempts = 0
            user_login_obj.last_failed_login_time = None
            user_login_obj.account_locked_flag = 0
            
        user_login_obj.logged_in_flag = 1
        user_login_obj.active_session_key = session_key
                    
        user_login_obj.save(False, True, None)        
        
    except Login_Data.DoesNotExist:
        create_user_login_info(user, 0, None, 1, session_key, 0)
            
    except:
        print 'Exception in update login status for user = ' + str(user)
        print traceback.print_exc()
    
    
def update_user_logout_status(user):
    try:
        user_login_obj = Login_Data.objects.get(user = user)
        user_login_obj.logged_in_flag = 0
        user_login_obj.active_session_key = None  
        user_login_obj.save(False, True, None)
    
    except Login_Data.DoesNotExist:        
        create_user_login_info(user, 0, None, 0, None, 0)        
        
    except:
        print 'Exception in logout for user = ' + str(user)
        print traceback.print_exc()
        
        
def update_failed_login_status(username):
    
    try:
        user = User.objects.get(username = username)
        user_login_obj = Login_Data.objects.get(user = user)
        
        user_login_obj.failed_login_attempts = user_login_obj.failed_login_attempts + 1
        user_login_obj.last_failed_login_time = datetime.datetime.now()
        
        if user_login_obj.failed_login_attempts >= settings.ALLOWED_FAILED_LOGIN_ATTEMPTS:
            user_login_obj.account_locked_flag = 1 
            
        user_login_obj.save(False, True, None)        
    
    except User.DoesNotExist:        
        pass
    
    except Login_Data.DoesNotExist:        
        create_user_login_info(user, 1, datetime.datetime.now(), 0, None, 0)        
        
    except:
        print 'Exception in failed login update for user = ' + str(user)
        print traceback.print_exc()
        

def create_user_login_info(user, failed_attempt_count, last_failed_attempt_time, logged_in_flag, session_key, locked_flag):
    try:
        user_login_obj = Login_Data()
        user_login_obj.user = user
        user_login_obj.failed_login_attempts = failed_attempt_count
        user_login_obj.last_failed_login_time = last_failed_attempt_time
        user_login_obj.logged_in_flag = logged_in_flag
        user_login_obj.active_session_key = session_key
        user_login_obj.account_locked_flag = locked_flag
        user_login_obj.save(True, False, None)
    except:
        print 'Error creating object'
        print traceback.print_exc()
        pass

def fetch_user_info(mobile_number, signature):
    result = {}
    transaction_type = Transaction_Type.objects.get(id = TRXN_USER_INFO_LOOKUP)
    #extra_param = module_helper.prepare_extra_transaction_param(transaction_type, BANK_YBL)
    request_text = '426*' + signature
    result_text = module_switchcaller.switch_caller(None, None, transaction_type, mobile_number, request_text, [{'key': 'sendSms', 'value': '1'}])
    status = module_responsehandler_new.user_reg_lookup_response(result_text)
    
    result['status'] = status
    if status == 'SUCCESS':
        val_array = result_text.splitlines()
        #print val_array
        print 'Mobile Number: ' + str(val_array[1])
        print 'Name: ' + str(val_array[2])
        print 'Type: ' + str(val_array[5])
        print 'Code: ' + str(val_array[14])
        #print 'Previous Mobile Number: ' + str(val_array[16])
        
        result['mobile'] = str(val_array[1])
        result['name'] = str(val_array[2])
        result['type'] = str(val_array[5])
        result['code'] = str(val_array[14])
        if len(val_array) == 17:
            result['prevmobile'] = str(val_array[16])
        else:
            result['prevmobile'] = ''    
        
    return result

def handle_user_account(mobile_number, name, code, type, prev_mobile_number):
    result = {}    
    
    status = 'DO_NOTHING'
    
    #check for existing code and existing cellnumber
    official_detail = Official_Detail.objects.filter(cspcode = code)
    username_obj = User.objects.filter(username = mobile_number)
    
    # If cspcode absent
    if len(official_detail) == 0:
        print 'Code not found in db'
        # If cellnumber absent - Create new user
        if len(username_obj) == 0:
            print 'Cellnumber not found in db'
            status = create_new_user(mobile_number, name, code, type)
            if status == 'USER_CREATION_SUCCESS':
                create_user_login_info(User.objects.get(username = mobile_number), 0, None, 0, None, 0)
                return_status = 'CREATE_PASSWORD_REQD'
            else:
                return_status = 'ERROR_ACCOUNT_CREATION'
            
        # If cellnumber present - Error case - 
        elif len(username_obj) == 1:
            print 'Cellnumber found in db'
            return_status = 'ERROR_CELLNUMBER_EXISTS'
        
    # If cspcode present
    elif len(official_detail) == 1:
        print 'Code found in db'
        # If cellnumber absent - Update cellnumber
        if len(username_obj) == 0:
            print 'Cellnumber not found in db'
            status = update_mobile_number(code, mobile_number)
            
            if status == 'UPDATE_MOBILE_SUCCESS':                
                user_obj = User.objects.get(username = mobile_number)
                
                if user_obj.password is None or user_obj.password == '':                    
                    return_status = 'CREATE_PASSWORD_REQD'
                
                else:                    
                    return_status = 'UPDATE_MOBILE_SUCCESS'                    
                    
            else:
                return_status = 'ERROR_UPDATE_MOBILE'
        
        # If cellnumber present
        elif len(username_obj) == 1:
            print 'Cellnumber found in db'
            # If incorrectly mapped 
            if official_detail[0].agent.user != username_obj[0]:
                print 'Incorrect code and cellnumber mapping'
                return_status = 'ERROR_CELLNUMBER_EXISTS_INCORRECT_MAPPING'
            
            # If correctly mapped
            elif official_detail[0].agent.user == username_obj[0]:  
                print 'Correct code and cellnumber mapping'  
                '''            
                if username_obj[0].password is None or username_obj[0].password == '':
                    print 'Password null'                
                else:                    
                    print 'Password not null'
                '''
                status = reset_user_login_data(mobile_number)
                
                if status == 'ACCOUNT_UNLOCKED' or status == 'RESET_SUCCESS':
                    return_status = 'CREATE_PASSWORD_REQD'
                    
                elif status == 'LOGIN_DATA_DOES_NOT_EXIST':
                    create_user_login_info(username_obj[0], 0, None, 0, None, 0)
                    return_status = 'CREATE_PASSWORD_REQD'
                    
                else:
                    return_status = status      
        

    result['status'] = return_status
    print 'Final status = ' + return_status
    return result
           

def create_new_user(mobile_number, name, code, type):
    print 'Creating new user: ' + str(mobile_number) + ', ' + str(name) + ', ' + str(code) + ', ' + str(type)
    try:
        # Create user entry
        user_obj = User()
        user_obj.username = mobile_number
        user_obj.first_name = name
        #user_obj.set_password(mobile_number)
        user_obj.is_staff = False
        user_obj.is_active = True
        user_obj.is_superuser = False
        user_obj.date_joined = datetime.datetime.now()
        
        group_obj = None
        agent_type_obj = None
        
        if type == '1':
            group_obj = Group.objects.get(id = GROUP_SUPER_AGENT)
            agent_type_obj = Agent_Type.objects.get(id = AGENT_TYPE_DISTRIBUTOR)
        elif type == '2':
            group_obj = Group.objects.get(id = GROUP_AGENT)
            agent_type_obj = Agent_Type.objects.get(id = AGENT_TYPE_RETAILER)
        elif type == '3':
            group_obj = Group.objects.get(id = GROUP_INDEPENDENT_AGENT)
            agent_type_obj = Agent_Type.objects.get(id = AGENT_TYPE_ICSP)   
            
        user_obj.save(True, False, None)
        group_obj.user_set.add(user_obj)       
                
        
        # Create cellnumber entry
        cellnumber_obj = Cellnumber_Detail()
        cellnumber_obj.user = user_obj
        cellnumber_obj.cellnumber = mobile_number
        cellnumber_obj.cellnumber_type = Cellnumber_Type.objects.get(id = CELLNUMBER_TYPE_PRIMARY)
        cellnumber_obj.is_active = True
        cellnumber_obj.save(True, False, None)
                
        # Creating agent entry
        agent_obj = Agent()
        agent_obj.user = user_obj
        agent_obj.agent_type = agent_type_obj
        agent_obj.prime_cell = cellnumber_obj
        agent_obj.is_active = True
        agent_obj.save(True, False, None)
                
        # Creating official detail entry
        official_detail_obj = Official_Detail()
        official_detail_obj.agent = agent_obj
        official_detail_obj.cspcode = code
        official_detail_obj.bank = get_bank_object_from_code(code)   
        official_detail_obj.save(True, False, None)     
        
        status = 'USER_CREATION_SUCCESS'
        
    except:        
        print 'Exception while creating user : ' + str(mobile_number) + ', ' + name + ', ' + str(code)
        print traceback.print_exc()
        status = 'USER_CREATION_FAILURE'
        
        # Delete if entries created
        if user_obj.id is not None:            
            user_obj.delete()
        if cellnumber_obj.id is not None:            
            cellnumber_obj.delete()
        if agent_obj.id is not None:            
            agent_obj.delete()
        if official_detail_obj.id is not None:            
            official_detail_obj.delete()        
    
    print status
    return status


def get_bank_object_from_code(code):
    print 'Determining bank for code = ' + code
    obj = None
    if str(code)[0:4] == '1006':
        obj = Bank.objects.get(id = BANK_SBI)
    elif str(code)[0:3] == '990':
        obj = Bank.objects.get(id = BANK_ICICI)
    elif str(code)[0:4] == 'UAT1' :
        obj = Bank.objects.get(id = PPI)
    elif str(code)[0:3] == 'Eko' :
        obj = Bank.objects.get(id = PPI)
    elif str(code)[0:3] == 'EKO' :
        obj = Bank.objects.get(id = PPI)
    print obj
    return obj
    
    
def update_mobile_number(code, mobile_number):
    print 'Updating mobile number: ' + str(code) + ', ' + str(mobile_number)
    try:
        official_detail = Official_Detail.objects.get(cspcode = code)
        agent_obj = Agent.objects.get(id = official_detail.agent.id)
        user_obj = User.objects.get(id = official_detail.agent.user.id)      
        cellnumber_obj = Cellnumber_Detail.objects.get(user = official_detail.agent.user, cellnumber_type_id = 1)        
    
        user_obj.username = mobile_number
        user_obj.last_login = datetime.datetime.now()
        user_obj.date_joined = datetime.datetime.now()                
        user_obj.save(False, True, None)
        
        cellnumber_obj.cellnumber = mobile_number
        cellnumber_obj.save(False, True, None)
        
        agent_obj.prime_cell = cellnumber_obj
        agent_obj.save(False, True, None)
        
        status = 'UPDATE_MOBILE_SUCCESS' 
    except:
        print 'Exception in update_mobile_number for cell: ' + str(mobile_number) + ', code: ' + str(code)
        print traceback.print_exc()
        status = 'UPDATE_MOBILE_FAILURE'
        
    print status
    return status


def reset_user_login_data(username):
    print 'Resetting user login data for: ' + str(username)
    try:
        user_obj = User.objects.get(username = username)
        login_data = Login_Data.objects.get(user = user_obj) 
                
        if login_data.failed_login_attempts == settings.ALLOWED_FAILED_LOGIN_ATTEMPTS and login_data.account_locked_flag == True:
            unlock_reqd = True
        else:
            unlock_reqd = False
                
        login_data.failed_login_attempts = 0
        login_data.last_failed_login_time = None
        login_data.logged_in_flag = False
        login_data.account_locked_flag = False
        login_data.active_session_key = None
        login_data.save(False, True, None)
        
        if unlock_reqd == True:        
            status = 'ACCOUNT_UNLOCKED'
            user_obj.password = ''
            user_obj.date_joined = datetime.datetime.now()
            user_obj.last_login = datetime.datetime.now()
            user_obj.save(False, True, None)
        else:        
            status = 'RESET_SUCCESS'
            
    except User.DoesNotExist:
        print 'Exception in reset_user_login_data for: ' + str(username)
        print 'Username does not exist'
        print traceback.print_exc()
        status = 'USER_DOES_NOT_EXIST'
        
    except Login_Data.DoesNotExist:
        print 'Exception in reset_user_login_data for: ' + str(username)
        print 'Login data does not exist'
        print traceback.print_exc()
        status = 'LOGIN_DATA_DOES_NOT_EXIST'
        
    except:
        print 'Exception in reset_user_login_data for: ' + str(username)
        print traceback.print_exc()
        status = 'RESET_FAILURE'
        
    print status
    return status


def set_password(mobile_number, password1, password2):
    print 'About to set password for mobile number: ' + str(mobile_number)
    result = {}
    user_obj = User.objects.get(username = mobile_number)
    if password1 == password2:
        user_obj.set_password(password1)
        user_obj.date_joined = datetime.datetime.now()
        user_obj.last_login = datetime.datetime.now()
        user_obj.save(False, True, None)
        result['status'] = constants.SUCCESS_STATUS
    else:
        result['status'] = 'PASSWORDS_MISMATCH'
        
    print result['status']
    return result