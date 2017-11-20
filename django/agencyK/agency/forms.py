from django.contrib.auth.models import User
from .models import Profile
from django import forms

'''
	create a user 
	form to be used for authorization
'''
class UserForm(forms.ModelForm):
    password = forms.CharField(widget=forms.PasswordInput)
    class Meta:
        model = User
        fields = ['username','email','password']
