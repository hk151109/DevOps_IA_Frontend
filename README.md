# DevOps IA Frontend

React application for a Google Classroom-style educational platform with plagiarism detection capabilities.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Local Development](#local-development)
- [Deployment](#deployment)
- [CI/CD Pipeline](#cicd-pipeline)
- [Environment Variables](#environment-variables)
- [Troubleshooting](#troubleshooting)

## 🎯 Overview

This React frontend provides a user-friendly interface for:
- Authentication and classroom management
- Student enrollment with classroom codes
- Assignment creation and submission
- AI-powered plagiarism detection and reporting

## ✨ Features

- **Authentication System**: Login/register for teachers and students
- **Classroom Management**: Teachers create classrooms, students join with codes
- **Assignment Workflow**: Teachers create posts/homework, students submit files
- **AI Analysis**: Automatic plagiarism detection with similarity scores
- **Report Generation**: HTML reports showing analysis results
- **Responsive Design**: Works on desktop and mobile devices

## 🚀 Local Development

### Prerequisites

- Node.js 18+ and npm
- Google Cloud SDK (for deployment)
- Access to the backend API

### Setup

1. **Clone and install dependencies:**
   ```bash
   git clone <repository-url>
   cd DevOps_IA_Frontend
   npm install
   ```

2. **Environment Configuration:**
   ```bash
   cp .env.example .env
   ```
   
   Update `.env` with your local backend URL:
   ```env
   REACT_APP_BASE_URL=http://localhost:4000
   ```

3. **Start development server:**
   ```bash
   npm run dev
   ```

   The app will be available at `http://localhost:3000`

## 🌐 Deployment

### Google App Engine Deployment

#### Initial Setup (One-time)

1. **Set up Google Cloud Project:**
   ```bash
   # Set your project ID
   gcloud config set project devops-ia-434015
   
   # Enable required APIs
   gcloud services enable appengine.googleapis.com
   gcloud services enable cloudbuild.googleapis.com
   
   # Create App Engine app (if not exists)
   gcloud app create --region=asia-south1
   ```

#### Manual Deployment

**Option 1: Using PowerShell Script (Windows)**
```powershell
.\deploy.ps1
```

**Option 2: Using Bash Script (Linux/Mac)**
```bash
chmod +x deploy.sh
./deploy.sh
```

**Option 3: Manual Commands**
```bash
# Install dependencies
npm ci --production=false

# Build the app
REACT_APP_BASE_URL=https://devops-ia-backend-226162055882.asia-south1.run.app NODE_ENV=production npm run build

# Deploy to App Engine
gcloud app deploy --quiet --promote --stop-previous-version
```

## 🔄 CI/CD Pipeline

### Cloud Build Trigger Setup

1. **Connect Repository to Cloud Build:**
   ```bash
   # Go to Cloud Build Console
   # https://console.cloud.google.com/cloud-build/triggers
   
   # Click "Create Trigger"
   # Connect your GitHub repository
   ```

2. **Create Trigger Configuration:**
   - **Name**: `frontend-deploy-trigger`
   - **Event**: Push to branch
   - **Source**: Select your repository
   - **Branch**: `^main$` (or your production branch)
   - **Configuration**: Cloud Build configuration file
   - **File location**: `cloudbuild.yaml`

3. **Advanced Settings:**
   - **Substitution variables**:
     - `_BACKEND_URL`: `https://devops-ia-backend-226162055882.asia-south1.run.app`
   - **Service account**: Use default or create specific one with required permissions

### Automatic Deployments

Once the trigger is set up:
- **Push to main branch** → Automatic deployment
- **Pull request** → Can be configured for preview deployments
- **Manual trigger** → Available in Cloud Build console

### Build Process

The CI/CD pipeline performs:
1. **Dependency Installation** (`npm ci`)
2. **Code Building** (`npm run build`)
3. **Build Verification** (check output files)
4. **App Engine Deployment** (with zero-downtime deployment)

## 🔧 Environment Variables

### Production Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `REACT_APP_BASE_URL` | Backend API URL | `https://devops-ia-backend-226162055882.asia-south1.run.app` |
| `NODE_ENV` | Environment mode | `production` |

### Setting Environment Variables

**In app.yaml:**
```yaml
env_variables:
  NODE_ENV: production
  REACT_APP_BASE_URL: https://your-backend-url.com
```

**In Cloud Build:**
```yaml
env:
  - 'REACT_APP_BASE_URL=${_BACKEND_URL}'
  - 'NODE_ENV=production'
```

## 🏗️ Project Structure

```
├── public/                 # Static files
├── src/                   # React source code
│   ├── api/              # API integration
│   ├── components/       # Reusable components
│   ├── pages/           # Page components
│   ├── contexts/        # React contexts
│   └── helpers/         # Utility functions
├── build/               # Production build (generated)
├── server.js           # Express server for production
├── app.yaml           # App Engine configuration
├── cloudbuild.yaml    # Cloud Build configuration
├── deploy.ps1/.sh     # Deployment scripts
└── package.json       # Dependencies and scripts
```

## 🩺 Health Checks

The application includes health check endpoints:

- **Health Check**: `GET /health`
  ```json
  {
    "status": "healthy",
    "timestamp": "2025-01-01T00:00:00.000Z",
    "service": "frontend"
  }
  ```

## 🐛 Troubleshooting

### Common Issues

1. **Build Failures:**
   ```bash
   # Clear npm cache
   npm cache clean --force
   
   # Remove node_modules and reinstall
   rm -rf node_modules package-lock.json
   npm install
   ```

2. **Deployment Issues:**
   ```bash
   # Check App Engine logs
   gcloud app logs tail -s default
   
   # Check Cloud Build logs
   gcloud builds list --limit=5
   gcloud builds log [BUILD_ID]
   ```

3. **Environment Variable Issues:**
   - Ensure all `REACT_APP_*` variables are set during build
   - Check `app.yaml` for production variables
   - Verify substitution variables in Cloud Build

4. **CORS Issues:**
   - Ensure backend `CLIENT_URL` matches frontend URL
   - Check CORS configuration in backend

### Logs and Monitoring

```bash
# View App Engine logs
gcloud app logs tail -s default

# View Cloud Build history
gcloud builds list

# Check App Engine versions
gcloud app versions list
```

## 📞 Support

For issues and questions:
1. Check the [Troubleshooting](#troubleshooting) section
2. Review Cloud Build and App Engine logs
3. Ensure backend connectivity and CORS settings

---

**Backend URL**: https://devops-ia-backend-226162055882.asia-south1.run.app
**Frontend URL**: Will be provided after deployment (format: `https://PROJECT_ID.appspot.com`)
