#!/bin/bash
cd /workspaces/skills-build-applications-w-copilot-agent-mode
npx create-react-app octofit-tracker/frontend --template cra-template --use-npm
npm install bootstrap --prefix octofit-tracker/frontend
npm install react-router-dom --prefix octofit-tracker/frontend
sed -i "1iimport 'bootstrap/dist/css/bootstrap.min.css';" octofit-tracker/frontend/src/index.js
