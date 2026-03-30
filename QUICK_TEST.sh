#!/bin/bash
# Quick API Test Commands for OctoFit Tracker
# Copy and paste these commands to test the API

# Set your Codespace name (replace with actual codespace name)
# Or leave empty for localhost testing
CODESPACE_NAME="${CODESPACE_NAME:-}"

if [ -z "$CODESPACE_NAME" ]; then
    BASE_URL="http://localhost:8000"
    echo "Testing on localhost..."
else
    BASE_URL="https://${CODESPACE_NAME}-8000.app.github.dev"
    echo "Testing on Codespace: $BASE_URL"
fi

echo ""
echo "=================================================="
echo "OctoFit Tracker API - Quick Test Commands"
echo "=================================================="
echo "Base URL: $BASE_URL"
echo ""

# Display curl commands you can copy/paste
echo "1. Test Root API"
echo "   curl -s $BASE_URL/api/ | jq ."
echo ""

echo "2. List Users"
echo "   curl -s $BASE_URL/api/users/ | jq ."
echo ""

echo "3. List Teams"
echo "   curl -s $BASE_URL/api/teams/ | jq ."
echo ""

echo "4. List Activities"
echo "   curl -s $BASE_URL/api/activities/ | jq ."
echo ""

echo "5. List Leaderboards"
echo "   curl -s $BASE_URL/api/leaderboards/ | jq ."
echo ""

echo "6. List Workouts"
echo "   curl -s $BASE_URL/api/workouts/ | jq ."
echo ""

echo "=================================================="
echo "To run these tests:"
echo "  ./test_api.sh"
echo "=================================================="
