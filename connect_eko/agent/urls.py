#copyright @ Eko India Financial Service Pvt. Ltd.
from django.conf.urls import patterns, url

urlpatterns = patterns('agent.views',
    url(r'^home/$', 'home_view',name='agent-home'),
   
    )
