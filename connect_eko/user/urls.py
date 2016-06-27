#copyright @ Eko India Financial Service Pvt. Ltd.
from django.conf.urls import patterns, include, url
from user.forms import CustomPasswordChangeForm
 
urlpatterns = patterns('user.views',
	url(r'^$', 'main', name='home_page'),
    url(r'^main/$', 'main', name='login_success_page'),
    url(r'^login/$', 'login_user',name='user-login'),
    url(r'^logout/$','logout_user',name='user-logout'),
    url(r'^user/account/$','account',name='user-account'),
    
)
urlpatterns += patterns('',
    url(r'^user/account/password_change/$','django.contrib.auth.views.password_change',
                {'post_change_redirect' : 'done/','current_app':'user','template_name':'user/password_change_form.html','password_change_form': CustomPasswordChangeForm},
                name="password_change"),
    (r'^user/account/password_change/done/$','django.contrib.auth.views.password_change_done',{'current_app':'user','template_name':'user/password_change_done.html',}),
    (r'^user/password/reset/(?P<uidb36>[0-9A-Za-z]+)-(?P<token>.+)/$', 'django.contrib.auth.views.password_reset_confirm', 
        {'post_change_redirect' : '/user/password/done/'}),
)


