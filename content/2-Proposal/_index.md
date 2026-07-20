---
title: "Proposal"
date: 2026-06-30
weight: 2
chapter: false
pre: " <b> 2. </b> "
---

# AWS Serverless Event Management Portal 
## Comprehensive Serverless Solution for Event Registration and Management

### 1. Executive Summary  
The AWS Serverless Event Management Portal is a comprehensive event management solution designed with a 100% serverless architecture on AWS. The system provides a web portal that allows users to register for events, join waitlists, check in via QR code, receive personalized event recommendations, and submit post-event reviews. By fully leveraging the AWS Free Tier (Always Free & 12 Months Free), this solution offers high performance and enterprise-grade security while keeping the monthly operating costs close to $0.

### 2. Problem Statement  
*Current Issues*  
Traditional event management systems incur continuous server hosting costs (e.g., EC2, RDS) even when idle. They lack the elasticity to scale rapidly during traffic spikes (like ticket sales launches) and often struggle with automated ticket check-ins and waitlist integrations.

*Proposed Solution*  
Build an Event-Driven Architecture utilizing AWS core services. The static web interface (React/Vite) is delivered via Amazon S3 and CloudFront. Backend logic and APIs are handled by Amazon API Gateway connected to AWS Lambda, which queries data from Amazon DynamoDB (using Single-Table Design). User authentication is delegated to Amazon Cognito, offloading server and security management overhead.

*Benefits and ROI*  
The solution delivers a professional platform featuring 12 API endpoints, integrated QR check-in, event recommendations, and robust security. Thanks to the pay-as-you-go model and AWS Free Tier optimization, monthly costs remain effectively at $0 for typical usage. Automating manual workflows and enabling instant deployment via CloudFormation/SAM significantly increases productivity and accelerates return on investment.

### 3. Solution Architecture  
The system operates on an **Event-Driven Architecture**, provisioning computing resources only when requested.

![Architecture](/images/event_portal_architecture.jpg)

*Core AWS Services*  
- **Amazon S3 & CloudFront**: Host and distribute the static web frontend.  
- **Amazon Cognito**: Manage users, distinguish between Client/Admin roles, and issue JWT Tokens.  
- **Amazon API Gateway**: REST API front door handling request routing and JWT validation.  
- **AWS Lambda**: Execute backend business logic (12 functions written in Node.js/TypeScript).  
- **Amazon DynamoDB**: NoSQL database optimized with Single-Table Design for performance.  
- **Amazon CloudWatch**: Monitor metrics, store logs, and trigger alarms.  

*Basic Data Flow*  
1. The user visits the domain and downloads static assets from S3 via CloudFront.
2. The user authenticates via Cognito to receive a JWT Token.
3. API requests are sent to API Gateway with the token.
4. API Gateway verifies the token and triggers the appropriate Lambda function.
5. Lambda reads/writes data in DynamoDB and returns the response to the frontend.

### 4. Technical Implementation  
The project is divided into Backend and Frontend components, both designed for automated or semi-automated deployment.

*Backend (AWS SAM/CloudFormation)*  
- **Stack**: Node.js/TypeScript.
- **Features**: 12 Lambda functions supporting registration, waitlist, QR check-in, recommendations, and .ics export.
- **Database**: Single-Table Design with 2 GSIs supporting 17 entity types, leveraging DynamoDB Streams to eventually synchronize remaining ticket counts.
- **Deployment**: Code is packaged and deployed using AWS CloudFormation (`template.yaml`) to automatically provision the entire backend infrastructure.

*Frontend (Vite/React)*  
- **UI/UX**: Built with Vite/React, featuring Protected Routes, Waitlist UI, User Profile, QR Check-in Page, and Review/Rating Components.
- **Deployment**: Compiled into static files (HTML, CSS, JS) and uploaded to an Amazon S3 bucket configured for Static Website Hosting.

### 5. Roadmap & Milestones  
The project was executed and completed over 4 weeks:
- **Week 1**: Foundation setup, DynamoDB table creation, basic APIs, and Frontend Protected Routes.  
- **Week 2**: Event registration flow, Cognito integration, Waitlist UI, and User Profile.  
- **Week 3**: Admin event management, QR Check-in scanner simulation, and Review/Rating system.  
- **Week 4**: Advanced features (Event recommendations, .ics calendar export, Member lists) and CloudFormation optimization.

### 6. Budget Estimation  
Architected to maximize the AWS Free Tier:  
- **AWS Lambda**: 1M requests/month, 400,000 GB-seconds -> $0  
- **Amazon DynamoDB**: 25 GB storage, 25 RCU/WCU -> $0  
- **Amazon CloudWatch**: 5 GB logs, 10 alarms -> $0  
- **Amazon S3**: 5 GB static storage -> $0  
- **Amazon Cognito**: Up to 50,000 Monthly Active Users -> $0  
- **Amazon API Gateway**: Billed after 12 months (or quota exceeded) at ~$3.50/1M requests.  

*Estimated Monthly Cost (for typical startup traffic)*: **~ $0**.

### 7. Risk Assessment  
*Risk Matrix & Mitigation Strategies*  
- **Lambda Cold Starts**:  
  - *Mitigation*: Keep Lambda deployment packages small and re-use DynamoDB connection pools.  
- **Database Throttling**:  
  - *Mitigation*: Enable Auto Scaling for DynamoDB or switch to On-Demand billing if traffic patterns are highly unpredictable.  
- **Unexpected Billing Overshoots**:  
  - *Mitigation*: Configure CloudWatch Billing Alarms to trigger email alerts if costs exceed $10.

### 8. Expected Outcomes  
An Enterprise-Grade, production-ready event management system capable of handling high loads. The platform smoothly supports the entire workflow—from event creation and ticket registration to physical check-ins—ensuring an excellent user experience while minimizing infrastructure maintenance and costs.