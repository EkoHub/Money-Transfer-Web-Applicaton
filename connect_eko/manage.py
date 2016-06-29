#!/usr/bin/env python
#copyright @ Eko India Financial Service Pvt. Ltd.

import os
import sys

if __name__ == "__main__":
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "connect_eko.settings")

    from django.core.management import execute_from_command_line

    execute_from_command_line(sys.argv)
