Quick deploy (GCP)

- Builds React static site and syncs to GCS bucket.
- Set _BUCKET substitution to your bucket name.
- Optional: set _URL_MAP to invalidate Cloud CDN.
- Ensure REACT_APP_BASE_URL is set at build time (use Cloud Build trigger env vars).
