---
title : "Verify deployment result"
date: 2026-06-30
weight : 5
chapter : false
pre : " <b> 5.5. </b> "
---

#### Verification checklist

After completing the deployment, verify that the Event Portal system works end to end.

#### 1. Backend stack status

Open AWS CloudFormation and confirm that the stack `EventApp-Backend-System` is in **CREATE_COMPLETE** status.

![CloudFormation stack complete](/images/5-Workshop/event-portal/04-cloudformation-complete.png)

#### 2. Backend outputs

Open the **Outputs** tab and confirm that the following values exist:

- **ApiUrl**
- **UserPoolId**
- **UserPoolClientId**
- **FrontendBucketName**

These outputs prove that the backend resources and frontend bucket were created successfully.

#### 3. S3 frontend hosting

Open the frontend S3 bucket and confirm that:

- Block Public Access is disabled for this bucket.
- Bucket policy allows `s3:GetObject` for website files.
- Static website hosting is enabled.
- The bucket website endpoint is available.

![Website endpoint](/images/5-Workshop/event-portal/07-copy-website-endpoint.png)

#### 4. Frontend files

Confirm that all files from the frontend `dist` folder were uploaded successfully to the frontend bucket.

![Frontend upload completed](/images/5-Workshop/event-portal/08-upload-frontend-files.png)

#### Result

When these checks are complete, the project is deployed with a static frontend on S3 and a serverless backend created by CloudFormation.