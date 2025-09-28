#!/bin/bash

echo "🚀 Manual Deployment Script"
echo "=========================="

# Set project (adjust if needed)
echo "📋 Setting project..."
gcloud config set project uniqscan

# Step 1: npm install
echo "📦 Step 1: Running npm install..."
npm install

# Step 2: yarn install
echo "🧶 Step 2: Running yarn install..."
yarn install

# Step 3: npm run build (with hardcoded backend URL)
echo "🏗️ Step 3: Building React app with hardcoded backend URL..."
# Use production environment file
cp .env.production .env.local
npm run build

# Step 4: gcloud app deploy
echo "🚀 Step 4: Deploying to Google App Engine..."
gcloud app deploy --quiet

echo "✅ Manual deployment completed!"
echo "🌐 Your app should be live at: https://uniqscan.appspot.com"