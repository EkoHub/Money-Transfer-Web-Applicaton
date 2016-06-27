#copyright @ Eko India Financial Service Pvt. Ltd.
from django import forms
from django.contrib import auth

# Form for change password
class ChangePasswordForm(forms.Form):
    current_password = forms.CharField(max_length=100,widget=forms.PasswordInput())
    new_password = forms.CharField(max_length=100,widget=forms.PasswordInput())
    new_password_copy = forms.CharField(max_length=100,widget=forms.PasswordInput())


class CustomPasswordChangeForm(auth.forms.PasswordChangeForm):
    MIN_LENGTH = 8
    
    password1 = forms.CharField(label=("New password"), widget=forms.PasswordInput)
    
    def clean_new_password1(self):
        password1 = self.cleaned_data.get('new_password1')

        # At least MIN_LENGTH long
        if len(password1) < self.MIN_LENGTH:
            raise forms.ValidationError("The new password must be at least %d characters long" % self.MIN_LENGTH)

        # At least one letter and one non-letter
        first_isalpha = password1[0].isalpha()
        if all(c.isalpha() == first_isalpha for c in password1):
            raise forms.ValidationError("The new password must contain at least one letter and at least one digit")

        return password1

CustomPasswordChangeForm.base_fields.keyOrder = ['old_password', 'new_password1', 'new_password2']