#!/bin/bash

# Test script for OctoFit Tracker API with codespace support

echo "======================================"
echo "OctoFit Tracker API Test"
echo "======================================"
echo ""

# Determine the host based on CODESPACE_NAME
if [ -n "$CODESPACE_NAME" ]; then
    API_HOST="https://$CODESPACE_NAME-8000.app.github.dev"
    echo "Using Codespace URL: $API_HOST"
else
    API_HOST="http://localhost:8000"
    echo "Using localhost URL: $API_HOST"
fi

echo ""
echo "Testing API endpoints..."
echo ""

# Test 1: API Root endpoint
echo "1. Testing API Root endpoint..."
echo "URL: $API_HOST/"
curl -s "$API_HOST/" | python -m json.tool || echo "Failed to get API root"
echo ""
echo "---"
echo ""

# Test 2: Users endpoint
echo "2. Testing Users endpoint..."
echo "URL: $API_HOST/api/users/"
curl -s "$API_HOST/api/users/" | python -m json.tool || echo "Failed to get users"
echo ""
echo "---"
echo ""

# Test 3: Teams endpoint
echo "3. Testing Teams endpoint..."
echo "URL: $API_HOST/api/teams/"
curl -s "$API_HOST/api/teams/" | python -m json.tool || echo "Failed to get teams"
echo ""
echo "---"
echo ""

# Test 4: Activities endpoint
echo "4. Testing Activities endpoint..."
echo "URL: $API_HOST/api/activities/"
curl -s "$API_HOST/api/activities/" | python -m json.tool || echo "Failed to get activities"
echo ""
echo "---"
echo ""

# Test 5: Leaderboards endpoint
echo "5. Testing Leaderboards endpoint..."
echo "URL: $API_HOST/api/leaderboards/"
curl -s "$API_HOST/api/leaderboards/" | python -m json.tool || echo "Failed to get leaderboards"
echo ""
echo "---"
echo ""

# Test 6: Workouts endpoint
echo "6. Testing Workouts endpoint..."
echo "URL: $API_HOST/api/workouts/"
curl -s "$API_HOST/api/workouts/" | python -m json.tool || echo "Failed to get workouts"
echo ""
echo "---"
echo ""

echo "======================================"
echo "API Test Complete"
echo "======================================"
