# Deployment Steps Summary

## Manual Deployment Steps

### For Linux/Mac (Cloud Shell):
```bash
chmod +x deploy-manual.sh
./deploy-manual.sh
```

### For Windows (PowerShell):
```powershell
.\deploy-manual.ps1
```

### Manual Step-by-Step Commands:
```bash
# 1. Install dependencies
npm install
yarn install

# 2. Set backend URL (hardcoded)
export REACT_APP_BASE_URL=https://devops-ia-backend-226162055882.asia-south1.run.app
export NODE_ENV=production

# 3. Build the app
npm run build

# 4. Deploy to GAE
gcloud app deploy --quiet
```

## CI/CD Pipeline (Automatic)

The `cloudbuild.yaml` file contains:
1. `npm install`
2. `yarn install` 
3. `npm run build` (with hardcoded REACT_APP_BASE_URL)
4. `gcloud app deploy`

**Backend URL is hardcoded in:**
- `cloudbuild.yaml` (for CI/CD)
- `app.yaml` (for runtime environment)
- `.env.production` (for local builds)

## Files with Hardcoded Backend URL:
- `cloudbuild.yaml`: Line 11 - `REACT_APP_BASE_URL=https://devops-ia-backend-226162055882.asia-south1.run.app`
- `app.yaml`: Line 10 - `REACT_APP_BASE_URL: https://devops-ia-backend-226162055882.asia-south1.run.app`
- `.env.production`: Line 3 - `REACT_APP_BASE_URL=https://devops-ia-backend-226162055882.asia-south1.run.app`

## Project Configuration:
- **Project ID**: uniqscan
- **Backend URL**: https://devops-ia-backend-226162055882.asia-south1.run.app
- **Frontend URL**: https://uniqscan.appspot.com (after deployment)