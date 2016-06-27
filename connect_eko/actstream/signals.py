#copyright @ Eko India Financial Service Pvt. Ltd.
from django.dispatch import Signal

action = Signal(providing_args=['verb', 'action_object', 'target',
                                'description', 'timestamp'])
