#!/bin/bash
# Configuration Verification Script for OctoFit Tracker

echo "=================================================="
echo "OctoFit Tracker Configuration Verification"
echo "=================================================="
echo ""

# Check settings.py
echo "1. Checking settings.py for ALLOWED_HOSTS..."
if grep -q "CODESPACE_NAME" octofit-tracker/backend/octofit_tracker/settings.py; then
    echo "   ✓ ALLOWED_HOSTS configured for Codespace"
else
    echo "   ✗ Missing CODESPACE_NAME configuration"
fi

# Check HTTPS configuration
echo ""
echo "2. Checking HTTPS/SSL configuration..."
if grep -q "SECURE_PROXY_SSL_HEADER" octofit-tracker/backend/octofit_tracker/settings.py; then
    echo "   ✓ HTTPS configuration added"
else
    echo "   ✗ Missing HTTPS configuration"
fi

# Check urls.py
echo ""
echo "3. Checking urls.py for API endpoints..."
if grep -q "'api'" octofit-tracker/backend/octofit_tracker/urls.py; then
    echo "   ✓ API endpoints configured"
else
    echo "   ✗ Missing API endpoints"
fi

# Check endpoints
echo ""
echo "4. Checking REST API ViewSets..."
endpoints=('users' 'teams' 'activities' 'leaderboards' 'workouts')
for endpoint in "${endpoints[@]}"; do
    if grep -q "'$endpoint'" octofit-tracker/backend/octofit_tracker/urls.py; then
        echo "   ✓ /$endpoint endpoint configured"
    else
        echo "   ✗ /$endpoint endpoint missing"
    fi
done

# Check launch.json
echo ""
echo "5. Checking VS Code launch.json..."
if grep -q "Launch Django Backend" .vscode/launch.json; then
    echo "   ✓ Django launch configuration present"
else
    echo "   ✗ Missing Django launch configuration"
fi

# Check test files
echo ""
echo "6. Checking test scripts..."
files=('test_api.sh' 'SETUP_GUIDE.md' 'API_SETUP_SUMMARY.md' 'QUICK_TEST.sh')
for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "   ✓ $file created"
    else
        echo "   ✗ $file missing"
    fi
done

echo ""
echo "=================================================="
echo "Environment Variables"
echo "=================================================="
echo "CODESPACE_NAME: ${CODESPACE_NAME:-'Not set (use localhost)'}"
echo "MONGO_DB_NAME: ${MONGO_DB_NAME:-'octofit_db (default)'}"
echo "MONGO_HOST: ${MONGO_HOST:-'localhost (default)'}"
echo "MONGO_PORT: ${MONGO_PORT:-'27017 (default)'}"

echo ""
echo "=================================================="
echo "API Endpoints Ready"
echo "=================================================="
if [ -z "$CODESPACE_NAME" ]; then
    base_url="http://localhost:8000"
else
    base_url="https://${CODESPACE_NAME}-8000.app.github.dev"
fi

echo "Base URL: $base_url"
echo ""
echo "Available endpoints:"
echo "  GET $base_url/api/ - Root API"
echo "  GET $base_url/api/users/ - Users"
echo "  GET $base_url/api/teams/ - Teams"
echo "  GET $base_url/api/activities/ - Activities"
echo "  GET $base_url/api/leaderboards/ - Leaderboards"
echo "  GET $base_url/api/workouts/ - Workouts"
echo "  GET $base_url/api/auth/ - Authentication"
echo "  GET $base_url/admin/ - Django Admin"

echo ""
echo "=================================================="
echo "Ready to Start Server!"
echo "=================================================="
echo ""
echo "Press F5 in VS Code to launch, or run:"
echo "  python octofit-tracker/backend/manage.py runserver 0.0.0.0:8000"
echo ""
