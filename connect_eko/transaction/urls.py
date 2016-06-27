#copyright @ Eko India Financial Service Pvt. Ltd.
'''
Created on Jun 10, 2016

@author: alankar
'''

from django.conf.urls import patterns, url

urlpatterns = patterns('transaction.views',
    url(r'^moneytransfer/$', 'moneytransfer', name = 'moneytransfer-home'),
    
   
)
