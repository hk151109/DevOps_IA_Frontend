# Manual Deployment Script for Windows (PowerShell)
# Usage: .\deploy-manual.ps1

Write-Host "🚀 Manual Deployment Script" -ForegroundColor Green
Write-Host "==========================" -ForegroundColor Green

# Set project (adjust if needed)
Write-Host "📋 Setting project..." -ForegroundColor Blue
gcloud config set project uniqscan

# Step 1: npm install
Write-Host "📦 Step 1: Running npm install..." -ForegroundColor Blue
npm install

# Step 2: yarn install
Write-Host "🧶 Step 2: Running yarn install..." -ForegroundColor Blue
yarn install

# Step 3: npm run build (with hardcoded backend URL)
Write-Host "🏗️ Step 3: Building React app with hardcoded backend URL..." -ForegroundColor Blue
# Use production environment file
Copy-Item ".env.production" -Destination ".env.local"
npm run build

# Step 4: gcloud app deploy
Write-Host "🚀 Step 4: Deploying to Google App Engine..." -ForegroundColor Blue
gcloud app deploy --quiet

Write-Host "✅ Manual deployment completed!" -ForegroundColor Green
Write-Host "🌐 Your app should be live at: https://uniqscan.appspot.com" -ForegroundColor Green