# Frontend Deployment to Google App Engine

## Simple Deployment

### Prerequisites
- Google Cloud SDK installed
- App Engine enabled in your project

### Deploy with Cloud Build (Recommended)
```bash
gcloud builds submit
```

### Manual Deploy
```bash
npm ci
npm run build
gcloud app deploy --quiet
```

## Configuration
- Backend URL: Set in `.env` file
- App will be available at: `https://PROJECT_ID.uc.r.appspot.com`
