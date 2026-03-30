from django.core.management.base import BaseCommand
from django.contrib.auth import get_user_model
from django.conf import settings
from octofit_tracker.models import Team, Activity, Leaderboard, Workout
import pymongo

User = get_user_model()

class Command(BaseCommand):
    help = 'Populate the octofit_db database with test data'

    def handle(self, *args, **options):
        # Drop collections directly via pymongo to avoid djongo pk-hashing bug
        client = pymongo.MongoClient(
            host=settings.MONGO_HOST,
            port=settings.MONGO_PORT,
        )
        db = client[settings.MONGO_DB_NAME]
        for collection in ['octofit_tracker_activity', 'octofit_tracker_leaderboard',
                           'octofit_tracker_user', 'octofit_tracker_team',
                           'octofit_tracker_workout', 'auth_user']:
            db[collection].drop()
        client.close()

        # Create teams
        marvel = Team.objects.create(name='Marvel')
        dc = Team.objects.create(name='DC')

        # Create users
        ironman = User.objects.create_user(username='ironman', email='ironman@marvel.com', password='password', first_name='Tony', last_name='Stark')
        batman = User.objects.create_user(username='batman', email='batman@dc.com', password='password', first_name='Bruce', last_name='Wayne')
        wonderwoman = User.objects.create_user(username='wonderwoman', email='wonderwoman@dc.com', password='password', first_name='Diana', last_name='Prince')
        spiderman = User.objects.create_user(username='spiderman', email='spiderman@marvel.com', password='password', first_name='Peter', last_name='Parker')

        # Create activities
        Activity.objects.create(user='ironman', type='Running', duration=30, team='Marvel')
        Activity.objects.create(user='batman', type='Cycling', duration=45, team='DC')
        Activity.objects.create(user='wonderwoman', type='Swimming', duration=60, team='DC')
        Activity.objects.create(user='spiderman', type='Jump Rope', duration=20, team='Marvel')

        # Create leaderboard
        Leaderboard.objects.create(team='Marvel', points=50)
        Leaderboard.objects.create(team='DC', points=60)

        # Create workouts
        Workout.objects.create(name='Hero HIIT', description='High intensity interval training for heroes.', suggested_for='Marvel')
        Workout.objects.create(name='Justice Yoga', description='Flexibility and balance for justice seekers.', suggested_for='DC')

        self.stdout.write(self.style.SUCCESS('octofit_db database populated with test data.'))
