from django.db import models
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):
    email = models.EmailField(unique=True)
    
    groups = models.ManyToManyField(
        'auth.Group',
        related_name='octofit_tracker_user_set',
        blank=True
    )
    user_permissions = models.ManyToManyField(
        'auth.Permission',
        related_name='octofit_tracker_user_set',
        blank=True
    )

class Team(models.Model):
    name = models.CharField(max_length=100, unique=True)

class Activity(models.Model):
    user = models.CharField(max_length=100)
    type = models.CharField(max_length=100)
    duration = models.IntegerField()
    team = models.CharField(max_length=100)

class Leaderboard(models.Model):
    team = models.CharField(max_length=100)
    points = models.IntegerField()

class Workout(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField()
    suggested_for = models.CharField(max_length=100)
