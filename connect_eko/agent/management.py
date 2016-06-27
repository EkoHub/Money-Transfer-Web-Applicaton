#copyright @ Eko India Financial Service Pvt. Ltd.
from django.db.models import signals

from django.utils.translation import ugettext_noop as _

try:
    from notification import models as notification
    def create_notice_types(app, created_models, verbosity, **kwargs):
        notification.create_notice_type("watched_ingredient_updated",
                                        _("Watched Ingredient Updated"),
                                        _("an ingredient you are watching has been updated"))

    signals.post_syncdb.connect(create_notice_types,
                                sender=notification)
except ImportError:
    print "Skipping creation of NoticeTypes as notification app not found"
