#copyright @ Eko India Financial Service Pvt. Ltd.
from datetime import datetime
from collections import defaultdict
from django.contrib.contenttypes.models import ContentType
from django.db.models import Q
from actstream.managers import ActionManager, stream
from django.db.models import get_model

class AgentActionManager(ActionManager):

    @stream
    def mystream(self, obj, verb='posted', time=None):
        if time is None:
            time = datetime.now()
        return obj.actor_actions.filter(verb = verb, timestamp__lte = time)

    @stream
    def user_stream_by_date(self, object,fromdate,todate, **kwargs):
        q = Q()
        qs = self.filter(public=True)
        actors_by_content_type = defaultdict(lambda: [])
        others_by_content_type = defaultdict(lambda: [])

        follow_gfks = get_model('actstream', 'follow').objects.filter(
            user=object).values_list('content_type_id',
                                     'object_id', 'actor_only')

        if not follow_gfks:
            return qs.none()

        for content_type_id, object_id, actor_only in follow_gfks.iterator():
            actors_by_content_type[content_type_id].append(object_id)
            if not actor_only:
                others_by_content_type[content_type_id].append(object_id)

        for content_type_id, object_ids in actors_by_content_type.iteritems():
            q = q | Q(
                actor_content_type=content_type_id,
                actor_object_id__in=object_ids,
            )
        for content_type_id, object_ids in others_by_content_type.iteritems():
            q = q | Q(
                target_content_type=content_type_id,
                target_object_id__in=object_ids,
            ) | Q(
                action_object_content_type=content_type_id,
                action_object_object_id__in=object_ids,
            )
        qs = qs.filter(Q(timestamp__gt=fromdate,timestamp__lt=todate),q, **kwargs) #only returns actions after specific id
        return qs


    @stream
    def user_stream_latest(self, object,id, **kwargs):
        q = Q()
        qs = self.filter(public=True)
        actors_by_content_type = defaultdict(lambda: [])
        others_by_content_type = defaultdict(lambda: [])

        follow_gfks = get_model('actstream', 'follow').objects.filter(
            user=object).values_list('content_type_id',
                                     'object_id', 'actor_only')

        if not follow_gfks:
            return qs.none()

        for content_type_id, object_id, actor_only in follow_gfks.iterator():
            actors_by_content_type[content_type_id].append(object_id)
            if not actor_only:
                others_by_content_type[content_type_id].append(object_id)

        for content_type_id, object_ids in actors_by_content_type.iteritems():
            q = q | Q(
                actor_content_type=content_type_id,
                actor_object_id__in=object_ids,
            )
        for content_type_id, object_ids in others_by_content_type.iteritems():
            q = q | Q(
                target_content_type=content_type_id,
                target_object_id__in=object_ids,
            ) | Q(
                action_object_content_type=content_type_id,
                action_object_object_id__in=object_ids,
            )
        qs = qs.filter(Q(pk__gt=id),q, **kwargs) #only returns actions after specific id
        return qs
