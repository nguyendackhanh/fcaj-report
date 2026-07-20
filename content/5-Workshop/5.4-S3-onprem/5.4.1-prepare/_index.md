---
title : "Configure frontend locally"
date: 2026-06-30
weight : 1
chapter : false
pre : " <b> 5.4.1. </b> "
---

#### Create environment file

Open the `frontend` folder and create a `.env` file at the same level as the `src` folder.

Add the values copied from CloudFormation Outputs:

```env
VITE_API_ENDPOINT=https://xxx.execute-api.ap-southeast-1.amazonaws.com/prod
VITE_COGNITO_USER_POOL_ID=ap-southeast-1_xxxxxxxxx
VITE_COGNITO_CLIENT_ID=abc123xyz456
```

#### Build frontend

Open Terminal and move to the frontend folder (Example):

```bash
cd "C:\Users\Sieu chu nhiem\Desktop\aws-serverless-event-portal\frontend"
```

Install dependencies:

```bash
npm install
```

Build the static website files:

```bash
npm run build
```

After the build completes, the frontend folder will contain a `dist` folder. This folder contains the static files that will be uploaded to Amazon S3.