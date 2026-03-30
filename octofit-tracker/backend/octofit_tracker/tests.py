from django.test import TestCase
from .models import User, Team, Activity, Leaderboard, Workout

class UserModelTest(TestCase):
    def test_create_user(self):
        user = User.objects.create(username='testuser', email='test@example.com')
        self.assertEqual(user.email, 'test@example.com')

class TeamModelTest(TestCase):
    def test_create_team(self):
        team = Team.objects.create(name='Test Team')
        self.assertEqual(team.name, 'Test Team')

class ActivityModelTest(TestCase):
    def test_create_activity(self):
        user = User.objects.create(username='testuser2', email='test2@example.com')
        team = Team.objects.create(name='Test Team 2')
        activity = Activity.objects.create(user=user, type='Run', duration=30, team=team)
        self.assertEqual(activity.type, 'Run')

class LeaderboardModelTest(TestCase):
    def test_create_leaderboard(self):
        team = Team.objects.create(name='Test Team 3')
        leaderboard = Leaderboard.objects.create(team=team, points=100)
        self.assertEqual(leaderboard.points, 100)

class WorkoutModelTest(TestCase):
    def test_create_workout(self):
        workout = Workout.objects.create(name='Test Workout', description='Desc', suggested_for='All')
        self.assertEqual(workout.name, 'Test Workout')
