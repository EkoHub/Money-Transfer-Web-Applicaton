#copyright @ Eko India Financial Service Pvt. Ltd.
'''
Modified on Jun 13, 2016

@author: siddharth
'''
from connect_eko import settings
from django.contrib.sessions.backends.db import Session
import datetime
from django.shortcuts import render_to_response,redirect
from django.template import RequestContext
from django.contrib import messages
from user.models import Login_Data
from user import module_user

# This middleware class ensures the session expiry is set to the prescribed time
class SessionExpiry(object):
    
    def process_request(self, request):
        if getattr(settings, 'SESSION_EXPIRY_SECONDS', None):
            request.session.set_expiry(settings.SESSION_EXPIRY_SECONDS)
        return None

# This middleware class ensures that only a single session is active for a user at a time
class SingleLoginInstance(object):    
    
    def process_request(self, request):
        # Inspect incoming session to check for sessionid manipulation
        if '_auth_user_id' in request.session:
            if request.session['_auth_user_id'] != request.user.id:
                print 'Inconsistent session, redirecting to login'
                messages.add_message(request, messages.WARNING, 'Your last session did not terminate properly')
                return render_to_response('user/login.html', context_instance=RequestContext(request))
            else:
                # consistent session, check further for currently active session
                ###########################
                try:
                    user_login_obj = Login_Data.objects.get(user = request.user)
                    current_key = user_login_obj.active_session_key
                    
                    if user_login_obj.account_locked_flag == 1:
                        messages.add_message(request, messages.WARNING, 'Account locked')
                        return render_to_response('user/login.html', context_instance=RequestContext(request))
                    
                    if current_key is not None:
                        if current_key != request.session.session_key:
                            try:
                                session_obj = Session.objects.get(session_key = current_key)
                                if session_obj.expire_date > datetime.datetime.now():
                                    messages.add_message(request, messages.WARNING, 'Already logged in!')
                                    return render_to_response('user/login.html', context_instance=RequestContext(request))
                                else:
                                    module_user.update_user_login_status(request.user, request.session.session_key)                    
                            except:
                                module_user.update_user_login_status(request.user, request.session.session_key)
                    else:
                        module_user.update_user_login_status(request.user, request.session.session_key)             
                    
                except Login_Data.DoesNotExist:
                    module_user.update_user_login_status(request.user, request.session.session_key)
                
                ###########################
                                           
        else:
            # do nothing
            pass    
            
        return None

#Site wide disabling CSRF checks
class DisableCSRF(object):
    def process_request(self, request):
        setattr(request, '_dont_enforce_csrf_checks', True)
            
