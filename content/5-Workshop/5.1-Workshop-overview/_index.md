---
title : "Workshop overview"
date: 2026-06-30
weight : 1 
chapter : false
pre : " <b> 5.1. </b> "
---

#### Deploy quickly with CloudFormation

The goal of this workshop is to deploy the Event Portal project with fewer manual steps by using **AWS CloudFormation**. The `template.yaml` file in the backend source code describes the required infrastructure, including DynamoDB, Cognito, Lambda functions, API Gateway, and the frontend S3 bucket.

With this approach, the deployment flow becomes simple:

1. Package the backend code and upload it to Amazon S3.
2. Update `template.yaml` so Lambda functions can load the packaged code from S3.
3. Upload the template to AWS CloudFormation and create the backend stack.
4. Copy the CloudFormation outputs and configure the frontend.
5. Build the frontend and upload the generated static files to the frontend S3 bucket.

#### Why use Infrastructure as Code?

- Reduces manual console operations.
- Keeps the AWS architecture consistent and repeatable.
- Makes it easier to rebuild the backend if needed.
- Reduces configuration drift between development and deployment.
- Helps the team document the actual infrastructure in source code.

#### AWS Services Used

- **Amazon S3**: Stores the packaged backend code and hosts the static frontend website.
- **AWS CloudFormation**: Infrastructure as Code (IaC) service used to automate the backend deployment via a template.
- **AWS Lambda**: Serverless compute service that runs backend business logic without managing servers.
- **Amazon API Gateway**: Acts as a front door, providing and managing RESTful APIs for the frontend.
- **Amazon DynamoDB**: A fast and flexible NoSQL database service used for storing application data.
- **Amazon Cognito**: Provides secure authentication and user management capabilities.

#### Final architecture

The finished system includes a static frontend hosted on S3, REST APIs served through API Gateway, backend logic running on Lambda, data stored in DynamoDB, and authentication handled by Cognito.

![Architecture](/images/architect.jpg)
