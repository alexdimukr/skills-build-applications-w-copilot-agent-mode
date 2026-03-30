#!/bin/bash

# Install frontend dependencies for OctoFit Tracker
echo "Installing bootstrap..."
npm install bootstrap --prefix octofit-tracker/frontend

echo "Installing react-router-dom..."
npm install react-router-dom --prefix octofit-tracker/frontend

echo "Frontend setup complete!"
