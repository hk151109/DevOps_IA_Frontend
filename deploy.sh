#!/bin/bash

# Deployment script for React Frontend to Google App Engine
# Usage: ./deploy.sh [environment]

set -e

ENVIRONMENT=${1:-"production"}
PROJECT_ID="devops-ia-434015"  # Replace with your actual project ID
BACKEND_URL="https://devops-ia-backend-226162055882.asia-south1.run.app"

echo "🚀 Starting deployment to Google App Engine..."
echo "Environment: $ENVIRONMENT"
echo "Project ID: $PROJECT_ID"
echo "Backend URL: $BACKEND_URL"

# Set the project
echo "📋 Setting project..."
gcloud config set project $PROJECT_ID

# Enable required APIs (run only once)
echo "🔧 Enabling required APIs..."
gcloud services enable appengine.googleapis.com --quiet
gcloud services enable cloudbuild.googleapis.com --quiet

# Install dependencies
echo "📦 Installing dependencies..."
npm ci --production=false

# Build the React app
echo "🏗️ Building React application..."
REACT_APP_BASE_URL=$BACKEND_URL NODE_ENV=production npm run build

# Verify build
if [ ! -d "build" ]; then
    echo "❌ Build directory not found! Build failed."
    exit 1
fi

echo "✅ Build completed successfully"
echo "📁 Build directory contents:"
ls -la build/

# Deploy to App Engine
echo "🚀 Deploying to App Engine..."
gcloud app deploy --quiet --promote --stop-previous-version

# Get the deployed URL
APP_URL=$(gcloud app describe --format="value(defaultHostname)")
echo "✅ Deployment completed!"
echo "🌐 Your app is live at: https://$APP_URL"

# Test the health endpoint
echo "🩺 Testing health endpoint..."
curl -f "https://$APP_URL/health" || echo "⚠️ Health check failed"

echo "🎉 Deployment process completed!"