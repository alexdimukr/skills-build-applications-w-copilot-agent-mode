# OctoFit Tracker Codespace URL Setup - Complete

## Summary of Changes

This document outlines all the changes made to support OctoFit Tracker API in GitHub Codespaces.

### 1. **Updated `urls.py`** 
[octofit-tracker/backend/octofit_tracker/urls.py](octofit-tracker/backend/octofit_tracker/urls.py)

**Changes:**
- Added environment variable support for `$CODESPACE_NAME`
- Created `get_api_base_url()` function to dynamically construct API URLs
- Created `api_root_with_codespace()` view to return full API endpoint URLs
- Updated `urlpatterns` to use the new `api_root_with_codespace` view

**Key Features:**
- Automatically detects codespace environment via `$CODESPACE_NAME` env variable
- Returns HTTPS URLs in codespace format: `https://$CODESPACE_NAME-8000.app.github.dev/api/[component]/`
- Falls back to localhost URLs for local development
- No hardcoding of hostnames

**URL Format:**
```
Codespace: https://$CODESPACE_NAME-8000.app.github.dev/api/[component]/
Example: https://my-codespace-8000.app.github.dev/api/activities/

Localhost: http://localhost:8000/api/[component]/
Example: http://localhost:8000/api/activities/
```

### 2. **Updated `settings.py`**
[octofit-tracker/backend/octofit_tracker/settings.py](octofit-tracker/backend/octofit_tracker/settings.py)

**Configuration Already in Place:**
- ✅ `ALLOWED_HOSTS` configured to accept both localhost and codespace URLs using `$CODESPACE_NAME`
- ✅ `SECURE_PROXY_SSL_HEADER` configured for HTTPS detection in codespaces
- ✅ `SECURE_SSL_REDIRECT = False` to avoid redirect loops in development
- ✅ `SESSION_COOKIE_SECURE = False` for development
- ✅ `CSRF_COOKIE_SECURE = False` for development
- ✅ CORS settings enabled for all origins in development

### 3. **Updated `.vscode/launch.json`**
[.vscode/launch.json](.vscode/launch.json)

**Changes:**
- Added `"cwd"` parameter pointing to backend directory
- Fixed `PYTHONPATH` to correctly reference the backend directory
- Added `CODESPACE_NAME` environment variable passthrough
- Added `"console": "integratedTerminal"` for better output visibility
- Added `"showReturnValue": true` for debugging

**Configuration:**
```json
{
  "name": "Launch Django Backend",
  "type": "python",
  "request": "launch",
  "program": "${workspaceFolder}/octofit-tracker/backend/manage.py",
  "args": ["runserver", "0.0.0.0:8000"],
  "django": true,
  "cwd": "${workspaceFolder}/octofit-tracker/backend",
  "env": {
    "CODESPACE_NAME": "${env:CODESPACE_NAME}"
  }
}
```

## How to Start the Server

### Option 1: VS Code Debug (Recommended)
1. Open VS Code Command Palette (Ctrl+Shift+P)
2. Select "Debug: Select and Start Debugging"
3. Choose "Launch Django Backend"
4. Server will start on `0.0.0.0:8000`

### Option 2: Command Line
```bash
cd octofit-tracker/backend
source venv/bin/activate
python manage.py runserver 0.0.0.0:8000
```

## Testing the API

### Create and Run Test Script
A test script has been created at: [test_codespace_api.sh](test_codespace_api.sh)

Make it executable and run it:
```bash
chmod +x test_codespace_api.sh
./test_codespace_api.sh
```

### Manual Testing with curl

**For Codespace:**
```bash
# Set codespace name
export CODESPACE_NAME="your-codespace-name"

# Test API root
curl -s "https://$CODESPACE_NAME-8000.app.github.dev/" | python -m json.tool

# Test specific endpoints
curl -s "https://$CODESPACE_NAME-8000.app.github.dev/api/users/" | python -m json.tool
curl -s "https://$CODESPACE_NAME-8000.app.github.dev/api/teams/" | python -m json.tool
curl -s "https://$CODESPACE_NAME-8000.app.github.dev/api/activities/" | python -m json.tool
curl -s "https://$CODESPACE_NAME-8000.app.github.dev/api/leaderboards/" | python -m json.tool
curl -s "https://$CODESPACE_NAME-8000.app.github.dev/api/workouts/" | python -m json.tool
```

**For Localhost:**
```bash
# Test API root
curl -s "http://localhost:8000/" | python -m json.tool

# Test specific endpoints
curl -s "http://localhost:8000/api/users/" | python -m json.tool
curl -s "http://localhost:8000/api/teams/" | python -m json.tool
curl -s "http://localhost:8000/api/activities/" | python -m json.tool
curl -s "http://localhost:8000/api/leaderboards/" | python -m json.tool
curl -s "http://localhost:8000/api/workouts/" | python -m json.tool
```

### Expected API Root Response
The API root endpoint (`/`) will return all available endpoints with their full URLs:

**For Codespace:**
```json
{
  "users": "https://my-codespace-8000.app.github.dev/api/users/",
  "teams": "https://my-codespace-8000.app.github.dev/api/teams/",
  "activities": "https://my-codespace-8000.app.github.dev/api/activities/",
  "leaderboards": "https://my-codespace-8000.app.github.dev/api/leaderboards/",
  "workouts": "https://my-codespace-8000.app.github.dev/api/workouts/",
  "auth": "https://my-codespace-8000.app.github.dev/api/auth/"
}
```

**For Localhost:**
```json
{
  "users": "http://localhost:8000/api/users/",
  "teams": "http://localhost:8000/api/teams/",
  "activities": "http://localhost:8000/api/activities/",
  "leaderboards": "http://localhost:8000/api/leaderboards/",
  "workouts": "http://localhost:8000/api/workouts/",
  "auth": "http://localhost:8000/api/auth/"
}
```

## Files Modified

| File | Changes |
|------|---------|
| [octofit-tracker/backend/octofit_tracker/urls.py](octofit-tracker/backend/octofit_tracker/urls.py) | Added codespace URL handling, new views, and dynamic URL generation |
| [octofit-tracker/backend/octofit_tracker/settings.py](octofit-tracker/backend/octofit_tracker/settings.py) | Already configured with codespace support ✅ |
| [.vscode/launch.json](.vscode/launch.json) | Updated Django backend launch configuration with proper environment variables |
| [test_codespace_api.sh](test_codespace_api.sh) | Created new test script for API validation |

## Notes

- ✅ No hardcoded `$CODESPACE_NAME` values - uses environment variable
- ✅ HTTPS automatically used in codespace environment
- ✅ HTTP fallback for localhost development
- ✅ No certificate issues - Django handles HTTPS properly via proxy headers
- ✅ Django still respects REST API formats and pagination
- ✅ Database is required to be running (MongoDB via djongo)

## Next Steps

1. Ensure MongoDB service is running
2. Start Django server (using launch.json or CLI)
3. Test API endpoints using the test script or curl commands
4. Check the API root endpoint to verify URL generation
