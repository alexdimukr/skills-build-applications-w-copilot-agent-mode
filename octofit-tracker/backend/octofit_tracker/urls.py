"""
URL configuration for octofit_tracker project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from . import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app import views
    2. Add a URL to urlpatterns:  path('', views.Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
import os
from django.contrib import admin
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from rest_framework.decorators import api_view
from rest_framework.response import Response
from . import views

def get_api_base_url(request):
    """Get the base API URL using codespace environment variable if available"""
    codespace_name = os.environ.get('CODESPACE_NAME')
    if codespace_name:
        # Use HTTPS for codespaces
        return f"https://{codespace_name}-8000.app.github.dev/api"
    else:
        # Use request.build_absolute_uri for localhost/development
        return request.build_absolute_uri('/api').rstrip('/')

@api_view(['GET'])
def api_root_with_codespace(request, format=None):
    """Root API endpoint that returns full URLs including codespace"""
    base_url = get_api_base_url(request)
    return Response({
        'users': f"{base_url}/users/",
        'teams': f"{base_url}/teams/",
        'activities': f"{base_url}/activities/",
        'leaderboards': f"{base_url}/leaderboards/",
        'workouts': f"{base_url}/workouts/",
        'auth': f"{base_url.replace('/api', '')}/api/auth/",
    })

router = DefaultRouter()
router.register(r'users', views.UserViewSet, basename='user')
router.register(r'teams', views.TeamViewSet, basename='team')
router.register(r'activities', views.ActivityViewSet, basename='activity')
router.register(r'leaderboards', views.LeaderboardViewSet, basename='leaderboard')
router.register(r'workouts', views.WorkoutViewSet, basename='workout')

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/auth/', include('dj_rest_auth.urls')),
    path('api/', include(router.urls)),
    path('', api_root_with_codespace, name='api-root'),
]
