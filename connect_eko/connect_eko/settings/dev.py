#copyright @ Eko India Financial Service Pvt. Ltd.
from connect_eko.settings.common import *

DEBUG = True

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql', # Add 'postgresql_psycopg2', 'mysql', 'sqlite3' or 'oracle'.
        'NAME': 'connect_eko_demo',                      # Or path to database file if using sqlite3./home/pradeep/projects/python/connect_eko/connect_eko/sqlite3.db
        # The following settings are not used with sqlite3:
        'USER': 'root',
        'PASSWORD': 'root',
        'HOST': '127.0.0.1',                      # Empty for localhost through domain sockets or '127.0.0.1' for localhost through TCP.
        'PORT': '3306',                      # Set to empty string for default.
    }
}

INTERNAL_IPS = ('127.0.0.1',)
