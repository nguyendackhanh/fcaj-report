---
title : "Create CloudFormation stack"
date: 2026-06-30
weight : 2
chapter : false
pre : " <b> 5.3.2. </b> "
---

#### Create stack

1. Open the **CloudFormation** service in AWS Console.
2. Choose **Create stack** and select **With new resources (standard)**.
3. In **Specify template**, choose **Upload a template file**.
4. Choose the updated `template.yaml` file and click **Next**.
5. In **Specify stack details**, enter:
   - **Stack name:** `EventApp-Backend-System`
   - **BillingAlertEmail:** your personal email address
6. Keep the default settings in **Configure stack options** and click **Next**.
7. In **Review**, scroll to the bottom and select the acknowledgement checkbox for IAM resources.
8. Click **Submit**.

#### Wait for completion

CloudFormation will create the backend resources. The deployment usually takes a few minutes. Refresh the Events tab until the stack status becomes **CREATE_COMPLETE**.

![CloudFormation stack complete](/images/5-Workshop/event-portal/04-cloudformation-complete.png)

#### Collect outputs

After the stack is created, open the **Outputs** tab and copy these values:

- **ApiUrl**: Backend API endpoint.
- **UserPoolId**: Cognito User Pool ID.
- **UserPoolClientId**: Cognito app client ID.
- **FrontendBucketName**: S3 bucket name for the frontend website.

These values are required when configuring and deploying the frontend.