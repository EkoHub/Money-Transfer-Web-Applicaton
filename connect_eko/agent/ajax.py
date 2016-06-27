#copyright @ Eko India Financial Service Pvt. Ltd.
from django.utils import simplejson
from dajaxice.decorators import dajaxice_register
from dajax.core import Dajax
from django.contrib.auth.decorators import login_required
from actstream.models import user_stream
from actstream.models import Action

@dajaxice_register
def sayhello(request):
    return simplejson.dumps({'message':'Hello World'})

@dajaxice_register(method='GET')
def saybye(request):
    return simplejson.dumps({'message':'Bye!'})

@login_required(login_url='/login/')    
@dajaxice_register(method='POST')
def assign_test(request,latest_act_id):
    dajax = Dajax()
    if latest_act_id is None:
        latest_act_id=0    
    action_list = list(Action.objects.user_stream_latest(request.user,latest_act_id))
    size = len(action_list)
    if(size>0):
		dajax.clear('span.newentry', 'innerHTML')
		dajax.assign('span.newentry', 'innerHTML', simplejson.dumps(size)+" new activity recorded, refresh page to see details")
		dajax.remove_css_class('div.newentry', 'hidden')
		dajax.add_css_class('div.newentry', 'active')
    
    return dajax.json()
