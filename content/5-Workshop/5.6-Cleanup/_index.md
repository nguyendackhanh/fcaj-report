---
title : "Clean up resources"
date: 2026-06-30
weight : 6
chapter : false
pre : " <b> 5.6. </b> "
---

Congratulations on completing this workshop. To avoid unnecessary AWS charges, clean up the resources that were created during the deployment.

#### 1. Delete CloudFormation stack

1. Open AWS CloudFormation.
2. Select the stack `EventApp-Backend-System`.
3. Choose **Delete stack**.
4. Confirm the deletion and wait until the stack is removed.

CloudFormation will delete the backend resources it created, such as Lambda functions, API Gateway, DynamoDB tables, Cognito resources, IAM roles, and related configuration.

#### 2. Empty and delete frontend bucket

1. Open Amazon S3.
2. Select the frontend bucket from CloudFormation Outputs.
3. Empty the bucket.
4. Delete the bucket after it becomes empty.

#### 3. Delete backend package bucket

If you created a separate S3 bucket to store the backend package, delete the uploaded backend package first, then delete the bucket.

Example backend package bucket:

```text
buketbackend
```

#### 4. Remove local build artifacts

You can also remove temporary local build artifacts if they are no longer needed:

- Backend `dist` package
- `backend-code.zip` or `backend.rar`
- Frontend `dist` folder

After cleanup, the workshop resources are removed and the AWS account will no longer be charged for the deployed project.