# Deployment script for React Frontend to Google App Engine (PowerShell)
# Usage: .\deploy.ps1 [environment]

param(
    [string]$Environment = "production"
)

$ErrorActionPreference = "Stop"

$PROJECT_ID = "devops-ia-434015"  # Replace with your actual project ID
$BACKEND_URL = "https://devops-ia-backend-226162055882.asia-south1.run.app"

Write-Host "🚀 Starting deployment to Google App Engine..." -ForegroundColor Green
Write-Host "Environment: $Environment" -ForegroundColor Yellow
Write-Host "Project ID: $PROJECT_ID" -ForegroundColor Yellow
Write-Host "Backend URL: $BACKEND_URL" -ForegroundColor Yellow

# Set the project
Write-Host "📋 Setting project..." -ForegroundColor Blue
gcloud config set project $PROJECT_ID

# Enable required APIs (run only once)
Write-Host "🔧 Enabling required APIs..." -ForegroundColor Blue
gcloud services enable appengine.googleapis.com --quiet
gcloud services enable cloudbuild.googleapis.com --quiet

# Install dependencies
Write-Host "📦 Installing dependencies..." -ForegroundColor Blue
npm ci --production=false

# Build the React app
Write-Host "🏗️ Building React application..." -ForegroundColor Blue
$env:REACT_APP_BASE_URL = $BACKEND_URL
$env:NODE_ENV = "production"
npm run build

# Verify build
if (!(Test-Path "build")) {
    Write-Host "❌ Build directory not found! Build failed." -ForegroundColor Red
    exit 1
}

Write-Host "✅ Build completed successfully" -ForegroundColor Green
Write-Host "📁 Build directory contents:" -ForegroundColor Blue
Get-ChildItem build

# Deploy to App Engine
Write-Host "🚀 Deploying to App Engine..." -ForegroundColor Blue
gcloud app deploy --quiet --promote --stop-previous-version

# Get the deployed URL
$APP_URL = gcloud app describe --format="value(defaultHostname)"
Write-Host "✅ Deployment completed!" -ForegroundColor Green
Write-Host "🌐 Your app is live at: https://$APP_URL" -ForegroundColor Green

# Test the health endpoint
Write-Host "🩺 Testing health endpoint..." -ForegroundColor Blue
try {
    Invoke-RestMethod -Uri "https://$APP_URL/health" -Method Get
    Write-Host "✅ Health check passed!" -ForegroundColor Green
} catch {
    Write-Host "⚠️ Health check failed: $($_.Exception.Message)" -ForegroundColor Yellow
}

Write-Host "🎉 Deployment process completed!" -ForegroundColor Green