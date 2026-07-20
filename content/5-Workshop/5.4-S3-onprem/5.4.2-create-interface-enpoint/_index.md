---
title : "Configure S3 bucket permissions"
date: 2026-06-30
weight : 2
chapter : false
pre : " <b> 5.4.2. </b> "
---

#### Disable Block Public Access

1. Open Amazon S3.
2. Open the bucket created by CloudFormation, for example `eventapp-frontend-333622375466-ap-southeast-1`.
3. Open the **Permissions** tab.
4. In **Block public access**, choose **Edit**.
5. Uncheck **Block all public access**.
6. Save changes and type `confirm` when AWS asks for confirmation.

![Disable block public access](/images/5-Workshop/event-portal/05-disable-block-public-access.png)

#### Add bucket policy

In the **Bucket policy** section, add a policy that allows public read access to website objects. Replace `<FrontendBucketName>` with your actual bucket name.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::<FrontendBucketName>/*"
        }
    ]
}
```

Save the bucket policy after updating the bucket name.