#!/usr/bin/env python
"""
Setup script to initialize Django and test OctoFit Tracker API
"""
import os
import sys
import django
import subprocess
import time

# Add backend to path
sys.path.insert(0, '/workspaces/skills-build-applications-w-copilot-agent-mode/octofit-tracker/backend')

# Setup Django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'octofit_tracker.settings')
django.setup()

print("✓ Django environment initialized")
print(f"✓ DEBUG mode: {os.environ.get('DEBUG', 'Not set')}")

# Check ALLOWED_HOSTS configuration
from django.conf import settings
print(f"\n✓ ALLOWED_HOSTS configured: {settings.ALLOWED_HOSTS}")

# Check CODESPACE_NAME environment
codespace_name = os.environ.get('CODESPACE_NAME', 'Not set')
print(f"✓ CODESPACE_NAME: {codespace_name}")

if codespace_name != 'Not set':
    print(f"✓ API URL: https://{codespace_name}-8000.app.github.dev/api/")
else:
    print(f"✓ API URL (local): http://localhost:8000/api/")

print("\n" + "="*60)
print("Setup complete! To run the Django server:")
print("="*60)
print("\nMethod 1: Use VS Code Launch Configuration")
print("  - Press F5 in VS Code")
print("  - Select 'Launch Django Backend'")
print("\nMethod 2: Run from terminal")
print("  - cd octofit-tracker/backend")
print("  - python manage.py runserver 0.0.0.0:8000")
print("\n" + "="*60)
