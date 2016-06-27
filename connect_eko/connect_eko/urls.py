#copyright @ Eko India Financial Service Pvt. Ltd.
from django.conf.urls import patterns, include, url

from django.contrib import admin
admin.autodiscover()
from dajaxice.core import dajaxice_autodiscover, dajaxice_config
dajaxice_autodiscover()



urlpatterns = patterns('',
    
    url(r'^admin/', include(admin.site.urls)),
    
    url(dajaxice_config.dajaxice_url, include('dajaxice.urls')),   
    
    url('^activity/', include('actstream.urls')),
        
    url(r'^', include('user.urls',namespace="user")), 
    
    url(r'^agent/', include('agent.urls',namespace="agent")),
    url(r'^transact/', include('transaction.urls',namespace="transaction")),
    
)

