---
title : "Upload frontend files"
date: 2026-06-30
weight : 4
chapter : false
pre : " <b> 5.4.4. </b> "
---

#### Upload build output

1. Open the frontend S3 bucket.
2. Open the **Objects** tab.
3. Choose **Upload**.
4. Select all files and folders inside the local frontend `dist` folder.
5. Upload them to the bucket.

![Upload frontend files](/images/5-Workshop/event-portal/08-upload-frontend-files.png)

#### Test the website

Open the **Bucket website endpoint** copied in the previous step. The Event Portal frontend should load and communicate with the serverless backend through the API endpoint configured in `.env`.

If the page loads but API data does not appear, verify the following values:

- `VITE_API_ENDPOINT`
- `VITE_COGNITO_USER_POOL_ID`
- `VITE_COGNITO_CLIENT_ID`
- S3 bucket policy and public access settings