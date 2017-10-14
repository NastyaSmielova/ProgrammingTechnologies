from django.db import models
import datetime


class Profile(models.Model):
   user = models.OneToOneField('auth.User')
   discount = models.IntegerField()
   totalSum = models.PositiveIntegerField(default=0)


class Activity(models.Model):
   description = models.CharField(max_length=250)
   name = models.CharField(max_length=50)
   class Meta:
      abstract = True

class Shopping(Activity):
   def __str__(self):
       return self.name

class Relaxation(Activity):
   price = models.IntegerField()
   def __str__(self):
       return self.name


class Excursion(Activity):
   photo = models.CharField(max_length=250)
   price = models.IntegerField()
   def __str__(self):
       return self.name



class Tour(models.Model):
   logo = models.CharField(max_length=250)
   name = models.CharField(max_length=50)
   relaxation = models.ForeignKey(Relaxation)
   shopping = models.ForeignKey(Shopping)
   excursion = models.ForeignKey(Excursion)
   date = models.DateField()
   price = models.IntegerField()
   isHot = models.BooleanField()
   time = models.TimeField(default=datetime.time(12, 0))
   places = models.PositiveIntegerField()
   def __str__(self):
       return self.name
