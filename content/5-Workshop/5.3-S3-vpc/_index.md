---
title : "Deploy backend with CloudFormation"
date: 2026-06-30
weight : 3
chapter : false
pre : " <b> 5.3. </b> "
---

#### Overview

In this section, you deploy the backend system in one CloudFormation stack. The stack creates the main serverless resources for the Event Portal project, including DynamoDB tables, Cognito resources, Lambda functions, and API Gateway.

Before creating the stack, update all `CodeUri: dist/` values in `template.yaml` so they point to the backend package uploaded to Amazon S3.

#### Content

- [Update template.yaml](5.3.1-create-gwe/)
- [Create CloudFormation stack and collect outputs](5.3.2-test-gwe/)

#### Deployment result

When the stack reaches **CREATE_COMPLETE**, the backend deployment is complete.

![CloudFormation stack complete](/images/5-Workshop/event-portal/04-cloudformation-complete.png)