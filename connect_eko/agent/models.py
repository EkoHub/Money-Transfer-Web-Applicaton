#copyright @ Eko India Financial Service Pvt. Ltd.
# System import
from django.db import models

from django.db.models.signals import post_save
from django.dispatch import receiver

# Custom import
from django.contrib.auth.models import User
from master.models import Agent_Type, Bank 
from user.models import Cellnumber_Detail
from actstream.actions import follow

# Classes begin here

class Agent(models.Model):
    user = models.ForeignKey(User) #ForeignKey.to_field fn can be used to define foreign key other than primary id
    agent_type = models.ForeignKey(Agent_Type)
    parent = models.ForeignKey('self', default=1) #default parent EKO id=1 for now first entry should be manually set as eko, Not sure about ForeignKey constraint , have to think on that
    prime_cell = models.ForeignKey(Cellnumber_Detail,blank=True,null=True) #Cellnumber_Details should be a model in user which maps by user_id contains different type of cell_number for users 
       
    is_active = models.BooleanField(default=False)
    
    def __unicode__(self):
        return str(self.id)+" : "+str(self.agent_type)+" : "+str(self.user.username)

    def get_parent(self):
        return str(self.parent.id)+" : "+str(self.parent.agent_type)


#official_details has OneToOne relationship with agent : because it has data unique to an agent ( in our case cspcode )
class Official_Detail(models.Model):
    agent = models.OneToOneField(Agent, primary_key=True)  #Foreign key defined here not in agent model because agent can optionally have official_detail ( bc or a supervising agent doesn't need official_detail ) 
    bank = models.ForeignKey(Bank,null=True,blank=True)
    cspcode = models.CharField(max_length=20,blank=True,null=True)
    cyberplat_term_id = models.CharField(max_length=100,null=True,blank=True)
    is_tatkal_allowed = models.BooleanField(default=False)
    is_blacklisted = models.BooleanField(default=False)

    def __unicode__(self):
        return str(self.agent_id)+" : "+str(self.cspcode)


@receiver(post_save,sender=Agent) 
def my_receiver(sender, **kwargs):
    if kwargs['created']:
	    instance = kwargs.get('instance')
	    follow(instance.parent.user,instance.user, send_action=False, actor_only=False)
	    print("Parent started following the agent")
	    print("Agent added!")



# Mapping of agents with their cellnumber which can be used for transaction
class Transaction_Cellnumber(models.Model):
    agent = models.ForeignKey(Agent)
    cell_number = models.ForeignKey(Cellnumber_Detail)
    is_active = models.BooleanField(default = True)
    
    def __unicode__(self):
        return str(self.cell_number)+" : "+str(self.agent)

