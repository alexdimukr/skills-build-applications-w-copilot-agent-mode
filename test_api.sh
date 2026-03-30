#!/bin/bash
# OctoFit Tracker API Test Script
# Tests the REST API endpoints

# Color output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Determine the base URL
if [ -n "$CODESPACE_NAME" ]; then
    BASE_URL="https://${CODESPACE_NAME}-8000.app.github.dev/api"
    echo -e "${BLUE}Using Codespace URL: ${BASE_URL}${NC}\n"
else
    BASE_URL="http://localhost:8000/api"
    echo -e "${BLUE}Using localhost URL: ${BASE_URL}${NC}\n"
fi

echo "=================================================="
echo "OctoFit Tracker API Test"
echo "=================================================="
echo ""

# Test 1: Root API endpoint
echo -e "${GREEN}Test 1: GET /api/ (Root API)${NC}"
echo "URL: ${BASE_URL}/"
curl -s -w "\nStatus: %{http_code}\n" "${BASE_URL}/" | head -20
echo ""

# Test 2: Users endpoint
echo -e "${GREEN}Test 2: GET /api/users/ (List Users)${NC}"
echo "URL: ${BASE_URL}/users/"
curl -s -w "\nStatus: %{http_code}\n" "${BASE_URL}/users/" | head -20
echo ""

# Test 3: Teams endpoint
echo -e "${GREEN}Test 3: GET /api/teams/ (List Teams)${NC}"
echo "URL: ${BASE_URL}/teams/"
curl -s -w "\nStatus: %{http_code}\n" "${BASE_URL}/teams/" | head -20
echo ""

# Test 4: Activities endpoint
echo -e "${GREEN}Test 4: GET /api/activities/ (List Activities)${NC}"
echo "URL: ${BASE_URL}/activities/"
curl -s -w "\nStatus: %{http_code}\n" "${BASE_URL}/activities/" | head -20
echo ""

# Test 5: Leaderboards endpoint
echo -e "${GREEN}Test 5: GET /api/leaderboards/ (List Leaderboards)${NC}"
echo "URL: ${BASE_URL}/leaderboards/"
curl -s -w "\nStatus: %{http_code}\n" "${BASE_URL}/leaderboards/" | head -20
echo ""

# Test 6: Workouts endpoint
echo -e "${GREEN}Test 6: GET /api/workouts/ (List Workouts)${NC}"
echo "URL: ${BASE_URL}/workouts/"
curl -s -w "\nStatus: %{http_code}\n" "${BASE_URL}/workouts/" | head -20
echo ""

echo "=================================================="
echo -e "${GREEN}API Tests Complete!${NC}"
echo "=================================================="
