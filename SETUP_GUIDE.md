# OctoFit Tracker API Setup & Testing Guide

## Overview
The OctoFit Tracker Django backend is configured to run on a Codespace at `https://$CODESPACE_NAME-8000.app.github.dev` and also supports localhost access.

## Configuration

### 1. Django Settings (`settings.py`)
The following configurations have been applied:

#### ALLOWED_HOSTS
- ✓ `localhost`
- ✓ `127.0.0.1`
- ✓ `$CODESPACE_NAME-8000.app.github.dev` (dynamically set from environment)

#### HTTPS/SSL Configuration
For Codespace HTTPS support:
- Uses `SECURE_PROXY_SSL_HEADER` to trust X-Forwarded-Proto header
- Configured for development mode (no redirect loops)

### 2. URLs Configuration (`urls.py`)
REST API endpoints are configured with DRF DefaultRouter:
- `/api/users/` - User management
- `/api/teams/` - Team management
- `/api/activities/` - Activity logging
- `/api/leaderboards/` - Leaderboard tracking
- `/api/workouts/` - Workout suggestions
- `/api/auth/` - Authentication endpoints

## Running the Server

### Method 1: VS Code Launch Configuration (Recommended)
1. Press **F5** in VS Code
2. Select **"Launch Django Backend"**
3. Server will start at `0.0.0.0:8000`

### Method 2: Command Line
```bash
cd octofit-tracker/backend
/path/to/venv/bin/python manage.py runserver 0.0.0.0:8000
```

### Method 3: Using Virtual Environment
```bash
cd octofit-tracker/backend
source venv/bin/activate
python manage.py runserver 0.0.0.0:8000
```

## Testing the API

### Option 1: Using the Test Script
```bash
chmod +x test_api.sh
./test_api.sh
```

The script automatically uses:
- Codespace URL if `$CODESPACE_NAME` is set
- Localhost URL if running locally

### Option 2: Manual curl Commands

#### Test Root API Endpoint
```bash
# Codespace
curl -s https://$CODESPACE_NAME-8000.app.github.dev/api/ | jq .

# Localhost
curl -s http://localhost:8000/api/ | jq .
```

#### List Users
```bash
# Codespace
curl -s https://$CODESPACE_NAME-8000.app.github.dev/api/users/ | jq .

# Localhost
curl -s http://localhost:8000/api/users/ | jq .
```

#### List Teams
```bash
curl -s https://$CODESPACE_NAME-8000.app.github.dev/api/teams/ | jq .
```

#### List Activities
```bash
curl -s https://$CODESPACE_NAME-8000.app.github.dev/api/activities/ | jq .
```

#### List Leaderboards
```bash
curl -s https://$CODESPACE_NAME-8000.app.github.dev/api/leaderboards/ | jq .
```

#### List Workouts
```bash
curl -s https://$CODESPACE_NAME-8000.app.github.dev/api/workouts/ | jq .
```

### Option 3: Using Python Requests
```python
import os
import requests

# Determine base URL
codespace_name = os.environ.get('CODESPACE_NAME')
if codespace_name:
    base_url = f"https://{codespace_name}-8000.app.github.dev/api"
else:
    base_url = "http://localhost:8000/api"

# Test root endpoint
response = requests.get(f"{base_url}/")
print(response.json())

# List users
response = requests.get(f"{base_url}/users/")
print(response.json())
```

## Codespace URL Format

The API endpoints follow this pattern:
```
https://$CODESPACE_NAME-8000.app.github.dev/api/[component]/
```

Examples:
- `https://mycodespace-8000.app.github.dev/api/users/`
- `https://mycodespace-8000.app.github.dev/api/teams/`
- `https://mycodespace-8000.app.github.dev/api/activities/`

## Environment Variables

The following environment variables are used:

| Variable | Purpose | Default |
|----------|---------|---------|
| `CODESPACE_NAME` | Codespace identifier | (set by GitHub) |
| `MONGO_DB_NAME` | MongoDB database name | `octofit_db` |
| `MONGO_HOST` | MongoDB host | `localhost` |
| `MONGO_PORT` | MongoDB port | `27017` |
| `MONGO_USER` | MongoDB username | (empty) |
| `MONGO_PASSWORD` | MongoDB password | (empty) |

## Troubleshooting

### 1. Server won't start
- Check if port 8000 is already in use
- Verify MongoDB is running: `ps aux | grep mongod`
- Check Django settings: `python manage.py check`

### 2. HTTPS Certificate Warning (Codespace)
- This is normal for development in Codespaces
- The proxy handles SSL termination
- Our configuration trusts the X-Forwarded-Proto header

### 3. CSRF Token Issues
- CSRF is disabled for development
- Configure CSRF_TRUSTED_ORIGINS if needed

### 4. Database Connection Issues
- Verify MongoDB is accessible
- Check connection parameters in settings.py
- Run migrations: `python manage.py migrate`

## Next Steps

1. ✓ Server is configured and ready to run
2. ✓ URLs are set up for REST API
3. ✓ Codespace HTTPS is configured
4. → Start the server using VS Code Launch or command line
5. → Test the endpoints using curl or the test script
6. → Begin API development!
