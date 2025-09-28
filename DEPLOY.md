# Quick Deploy Guide

## Option 1: Manual Deploy
```bash
gcloud builds submit
```

## Option 2: Set up auto-deploy on git push
```bash
gcloud builds triggers create github \
  --repo-name=DevOps_IA_Frontend \
  --repo-owner=hk151109 \
  --branch-pattern="^main$" \
  --build-config=cloudbuild.yaml \
  --name=frontend-deploy
```

Done! Your frontend will auto-deploy on every push to main branch.