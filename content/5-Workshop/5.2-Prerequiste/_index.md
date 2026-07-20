---
title : "Prepare backend code"
date: 2026-06-30
weight : 2 
chapter : false
pre : " <b> 5.2. </b> "
---

#### Purpose

In this step, you package the backend source code and upload it to Amazon S3. CloudFormation will later use this uploaded package to create Lambda functions automatically.

#### 1. Build backend code locally

1. Open Terminal or Command Prompt.
2. Move to the backend folder (Example):

```bash
cd "C:\Users\Sieu chu nhiem\Desktop\aws-serverless-event-portal\backend"
```

3. Install dependencies:

```bash
npm install
```

4. Build TypeScript source code into JavaScript:

```bash
npm run build
```

5. After the build completes, the backend folder will contain a `dist` folder.
6. Copy `package.json` and `node_modules` into the `dist` folder.
7. Compress all files inside `dist` into a package such as `backend-code.zip` or `backend.rar`.

#### 2. Create an S3 bucket for backend package

Open the Amazon S3 console and create a bucket in the **Asia Pacific (Singapore) ap-southeast-1** Region. In this workshop, the backend package was uploaded to a bucket named `buketbackend`.

![Create backend bucket](/images/5-Workshop/event-portal/01-create-backend-bucket.png)

#### 3. Upload backend package

Open the bucket, choose **Upload**, select the packaged backend file, and upload it to S3.

![Upload backend package](/images/5-Workshop/event-portal/02-upload-backend-code.png)

#### 4. Copy the object URL or S3 URI

After the upload succeeds, open the uploaded object and copy the **Object URL** or **S3 URI**. This value will be used in `template.yaml`.

![Copy backend object URL](/images/5-Workshop/event-portal/03-copy-backend-object-url.png)

Example object URL:

```text
https://buketbackend.s3.ap-southeast-1.amazonaws.com/backend.rar
```

After this step, keep the backend package URL carefully and continue to the CloudFormation deployment step.