# OctoFit Tracker Frontend Setup Guide

## Project Overview

The OctoFit Tracker frontend is a React application that displays fitness data from the Django REST Framework backend. It includes:

- **Navigation Menu** - Using React Router DOM for page navigation
- **Components** - Each component fetches and displays data from the API
- **Bootstrap Integration** - Professional styling with Bootstrap 5
- **Console Logging** - Detailed logging for debugging API calls and data

## Frontend Structure

```
octofit-tracker/frontend/
├── public/                    # Static files
├── src/
│   ├── api/
│   │   └── api.js            # API utility functions for fetching data
│   ├── components/
│   │   ├── Activities.js      # Activities component
│   │   ├── Leaderboard.js     # Leaderboard component
│   │   ├── Teams.js           # Teams component
│   │   ├── Users.js           # Users component
│   │   └── Workouts.js        # Workouts component
│   ├── App.js                 # Main app component with routing
│   ├── App.css                # App styling
│   ├── index.js               # React entry point
│   ├── index.css              # Global styles
│   └── setupTests.js          # Test setup
├── package.json               # Dependencies
├── .env.example               # Environment variables example
└── .gitignore                 # Git ignore file
```

## API Integration

### Base URL Configuration

The API base URL is determined by the environment:

- **GitHub Codespaces**: `https://{CODESPACE_NAME}-8000.app.github.dev`
- **Local Development**: `http://localhost:8000`

The `REACT_APP_CODESPACE_NAME` environment variable is automatically set by GitHub Codespaces.

### API Endpoints

The frontend connects to these Django REST API endpoints:

- `/api/users/` - List all users
- `/api/activities/` - List all activities
- `/api/teams/` - List all teams
- `/api/leaderboard/` - Get leaderboard data
- `/api/workouts/` - List all workouts

### Data Handling

The `api.js` utility function handles:

1. **Paginated Responses** - DRF returns paginated data with `.results` property
2. **Plain Array Responses** - Direct array returns
3. **Error Handling** - Catches and logs API errors
4. **Console Logging** - Logs all API calls for debugging

Example console output:
```
🔗 Fetching data from: https://my-codespace-8000.app.github.dev/api/users/
✅ Data fetched from /api/users/: [...]
📄 Paginated response - returning 20 items
```

## Components

### 1. Users Component
- **Endpoint**: `/api/users/`
- **Displays**: User profiles (ID, Username, Email, Profile)
- **Features**: Loading states, error handling, data table with responsive design

### 2. Activities Component
- **Endpoint**: `/api/activities/`
- **Displays**: Activity records (Name, Type, Duration, Calories, Date)
- **Features**: Date formatting, responsive table

### 3. Teams Component
- **Endpoint**: `/api/teams/`
- **Displays**: Team information (Name, Description, Created Date, Members count)
- **Features**: Team management display

### 4. Leaderboard Component
- **Endpoint**: `/api/leaderboard/`
- **Displays**: Rankings (Rank, User, Points, Activities, Score)
- **Features**: Ranked display with badges

### 5. Workouts Component
- **Endpoint**: `/api/workouts/`
- **Displays**: Workout plans (Name, Type, Duration, Difficulty, Created Date)
- **Features**: Difficulty badges

## Running the Application

### Prerequisites

- Node.js (v14 or higher)
- npm (v6 or higher)
- Backend API running at `http://localhost:8000` or GitHub Codespaces URL

### Development Mode

```bash
# Navigate to the frontend directory
cd octofit-tracker/frontend

# Install dependencies (already done)
npm install

# Start the development server
npm start
```

The app will open at `http://localhost:3000`

### Production Build

```bash
cd octofit-tracker/frontend

# Create production build
npm build

# Output is in the build/ directory
```

## Environment Configuration

### For GitHub Codespaces

The environment variable `REACT_APP_CODESPACE_NAME` is automatically set. No manual configuration is needed.

### For Local Development

Create a `.env` file in `octofit-tracker/frontend/`:

```
# .env file (for local development)
# Leave REACT_APP_CODESPACE_NAME empty for local development
```

Leave the variable unset to use the local API endpoint (`http://localhost:8000`).

## Console Logging

Each component logs detailed information for debugging:

```javascript
// Component loading
👥 Loading Users component...

// API endpoint being called
🔗 Fetching data from: http://localhost:8000/api/users/

// Successful data fetch
✅ Data fetched from /api/users/: [...]

// Data format detection
📄 Paginated response - returning 20 items
📋 Plain array response - returning 15 items

// Errors
❌ Error fetching from /api/users/: Error message
❌ Failed to load users: Error message
```

Open the browser's Developer Tools (F12) and go to the Console tab to see these logs.

## Navigation

The app includes a responsive Bootstrap navbar with links to:

- **Home** (🐙) - Welcome page
- **👥 Users** - User management
- **🏃 Activities** - Activity logging
- **🏆 Teams** - Team management
- **🥇 Leaderboard** - Competitive rankings
- **💪 Workouts** - Workout suggestions

## Dependencies

- **react** (^19.2.4) - UI framework
- **react-dom** (^19.2.4) - React DOM utilities
- **react-router-dom** (^6.20.0) - Routing and navigation
- **bootstrap** (^5.3.0) - CSS framework
- **react-scripts** (5.0.1) - Create React App tooling

## Styling

The app uses:

- **Bootstrap 5** - For responsive layout and components
- **Custom CSS** - In `App.css` for additional styling
- **Emoji Icons** - For visual appeal and user-friendly labels

## Error Handling

All components include:

- Loading states while fetching data
- Error messages if API calls fail
- try-catch blocks for error handling
- User-friendly error displays

## Debugging Tips

1. **Open Browser Console** - Press F12 to see all console logs
2. **Check Network Tab** - Monitor API requests and responses
3. **Verify API is Running** - Ensure backend is accessible
4. **Check Environment Variable** - Verify REACT_APP_CODESPACE_NAME is set correctly
5. **Check Codespace Port 8000** - Ensure backend is running and public

## Common Issues

### "Cannot fetch from API"
- Ensure backend is running
- Check port 8000 is publicly accessible in Codespaces
- Verify REACT_APP_CODESPACE_NAME environment variable is set

### "No data displayed"
- Check browser console for errors
- Verify API endpoints exist in Django backend
- Check that database has data

### "CORS errors"
- Ensure django-cors-headers is installed in backend
- Check CORS settings in Django settings.py
