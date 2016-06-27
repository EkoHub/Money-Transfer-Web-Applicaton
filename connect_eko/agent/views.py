#copyright @ Eko India Financial Service Pvt. Ltd.
from django.shortcuts import render_to_response,redirect
from django.core.urlresolvers import reverse
from django.contrib.auth import authenticate, login
from django.contrib.auth import logout    
from django.contrib.auth.decorators import login_required
from user.settings import LOGIN_URL
from django.http import HttpResponse
from django.template import RequestContext
from agent.models import Agent
from django.contrib.auth.models import User
from django.contrib import messages
from django.db.models import Q
from actstream.actions import follow
from django.contrib.contenttypes.models import ContentType
from actstream import actions, models, compat
from master.constants import AGENT_TYPE_FOS,AGENT_TYPE_DISTRIBUTOR,AGENT_TYPE_RETAILER, AGENT_TYPE_ICSP
from actstream.models import Action
from datetime import datetime,timedelta
import traceback

User = compat.get_user_model()

# homeview Of the agent
@login_required(login_url='/login/')
def home_view(request):
    print("Inside agent::home_view()", request.user.username)
    redirecturl = None
    try:
        #TODO:wrap all routing functionalities into one fn
        agent = Agent.objects.filter(user=request.user)#TODO : make query to fetch agents by usernameinurl
        #Case1:IF user is nor an agent or admin. Admin would have been redirected to /admin from /user
        if(agent[0].agent_type_id == AGENT_TYPE_RETAILER or agent[0].agent_type_id == AGENT_TYPE_ICSP):
            redirecturl = reverse('transaction:moneytransfer-home',kwargs={})
        else:
            return render_to_response('404.html') 
        
        #Case2:IF user has only one agent role
        #else:
            #messages.add_message(request, messages.INFO, 'Welcome to Connect')
        c = RequestContext(request,{'agents_list' : agent})
        #return render_to_response('agent/dashboard.html',c)
        if(redirecturl is None):
            return render_to_response('404.html') 
        else:
            return redirect(redirecturl)
    except:
        print(traceback.print_exc())
        return render_to_response('404.html')
 



