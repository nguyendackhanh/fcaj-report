---
title: "Workshop"
date: 2026-06-30
weight: 5
chapter: false
pre: " <b> 5. </b> "
---


# Deploy AWS Serverless Event Portal with CloudFormation

#### Overview

This workshop guides you through deploying an **AWS Serverless Event Portal** quickly by using **Infrastructure as Code (IaC)** with **AWS CloudFormation**. Instead of manually creating each database, Lambda function, API Gateway, Cognito resource, and S3 bucket, you use a `template.yaml` file as the architecture blueprint.

CloudFormation reads this blueprint and provisions the backend resources automatically. After the backend is created, you collect the API and Cognito outputs, configure the frontend, and host the static website on Amazon S3.

#### Main AWS services

- **Amazon S3**: Stores the packaged backend code and hosts the frontend website.
- **AWS CloudFormation**: Provisions the backend system from the `template.yaml` file.
- **AWS Lambda**: Runs serverless backend business logic.
- **Amazon API Gateway**: Exposes REST APIs for the frontend.
- **Amazon DynamoDB**: Stores application data.
- **Amazon Cognito**: Provides authentication resources for users.

#### Content

1. [Workshop overview](5.1-Workshop-overview/)
2. [Prepare backend code and upload to S3](5.2-Prerequiste/)
3. [Deploy backend with CloudFormation](5.3-S3-vpc/)
4. [Deploy frontend with Amazon S3](5.4-S3-onprem/)
5. [Verify deployment result](5.5-Policy/)
6. [Clean up resources](5.6-Cleanup/)