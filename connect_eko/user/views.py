#copyright @ Eko India Financial Service Pvt. Ltd.
from django.http import *
from django.shortcuts import render_to_response,redirect
from django.template import RequestContext
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login, logout, get_user
from django.core.urlresolvers import reverse
from django.contrib import messages
from user.forms import ChangePasswordForm
from django.contrib.auth.forms import PasswordChangeForm
from django.http import HttpResponse
from user import module_user
from agent.models import Agent, Official_Detail
from master import constants
import traceback

# Starting function wgich is called when user logged in
def login_user(request):
    print('Inside user::login_user()')
    try:
        logout(request)
        
        if request.POST:
            username = request.POST['username']
            password = request.POST['password']
            status = module_user.user_login_status(username)
            if status == constants.ACCOUNT_LOCKED:    #if the user account is locked
                messages.add_message(request, messages.WARNING, 'Account locked!')
            else:         
                user = authenticate(username=username, password=password)
                if user is not None:
                    if user.is_active:
                        login(request, user)
                        if status == constants.ACCOUNT_ACTIVE_FIRST_LOGIN:  #if user logged in for the first time then provide option for password change
                            return redirect('user:password_change')
                        else:
                            return redirect('user:login_success_page') #redirect user to the homepage
                    else:
                        messages.add_message(request, messages.ERROR, 'User account inactive')
                else:
                    module_user.update_failed_login_status(username)
                    messages.add_message(request, messages.ERROR, 'Username and Password did not match')
        return render_to_response('user/login.html', context_instance=RequestContext(request))
    except:
        print(traceback.print_exc())
 

def main(request):
    if request.user.is_authenticated():
        if not request.user.is_staff:
            return redirect(reverse('agent:agent-home',kwargs={}))
        #Quick fix to remove dot from username: ''.join(e for e in request.user.username if e.isalnum()) 
        
        else:
            
            if request.user.is_superuser:
                return redirect('admin:index')
            else:
                url_string = str(request.META.get('HTTP_REFERER'))
                if '?next=' in url_string:
                    url_array = url_string.split('?next=')
                    if len(url_array) == 2:
                        return HttpResponseRedirect(url_array[1])
                    else: 
                        return render_to_response("404.html")
                user_type_obj = User_Type.objects.get(user=request.user)
                if user_type_obj is None:
                    return render_to_response('404.html')
              
    else:
        #return redirect('user:user-login')
        return render_to_response('user/login.html', context_instance=RequestContext(request))
 
# Logout function
def logout_user(request):
    module_user.update_user_logout_status(get_user(request))
    logout(request)
    return render_to_response('user/login.html', context_instance=RequestContext(request))

#for changing password django default auth change_password used intead of below
@login_required(login_url='/login/')
def change_password(request):
    if request.method == 'POST': # If the form has been submitted...
        form = PasswordChangeForm(request.POST) # A form bound to the POST data
        if form.is_valid(): # All validation rules pass
            current_password = form.cleaned_data['current_password']
            new_password = form.cleaned_data['new_password']
            
            messages.add_message(request, messages.WARNING, 'Your password changed successfully')
            return redirect(reverse('agent:agent-home',kwargs={})) # Redirect after POST
    else:
        form = PasswordChangeForm() # An unbound form

    return render_to_response('user/change_password.html',{'form': form,},context_instance=RequestContext(request))

# This shows the account of the agent
@login_required(login_url='/login/')
def account(request):
    if not request.user.is_staff:
        mobile_number = None
        code = None
        try:
            agent = Agent.objects.filter(user = request.user)[0]
            mobile_number = agent.prime_cell.cellnumber
            code = Official_Detail.objects.get(agent = agent).cspcode 
        except:
            pass      
        return render_to_response('user/account_agent.html', context_instance=RequestContext(request, {'mobile_number': mobile_number, 'code': code}))
    else:
        return render_to_response('user/account.html', context_instance=RequestContext(request))
