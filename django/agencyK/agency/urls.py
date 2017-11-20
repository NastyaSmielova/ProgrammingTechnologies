from django.conf.urls import url
from django.contrib.auth import views as auth_views

from . import views

app_name = 'agency'

'''
	register urls to work with
	show main page, available tours, detail information about specific tour,buy tour
	work with user(log in,out,register)
'''

urlpatterns = [
    url(r'^$', views.mainPage, name='mainPage'),
    url(r'^tours/$', views.IndexView.as_view(), name='index'),
    url(r'^register/$', views.UserFormView.as_view(), name='register'),
    url(r'^user_login/$', views.user_login, name='user_login'),

    url(r'^loginout/$', views.loginout, name='loginout'),
    url(r'^buy/(?P<tour_id>[0-9]+)/$', views.buy, name='buy'),
    url(r'^buyTour/(?P<tour_id>[0-9]+)/$', views.buyTour, name='buyTour'),
    url(r'^tours/(?P<pk>[0-9]+)/$', views.DetailView.as_view(), name='detail'),
]