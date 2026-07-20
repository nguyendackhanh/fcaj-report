---
title: "Blog 6: Building a scalable user search layer on top of Amazon Cognito"
date: 2026-06-01
weight: 6
chapter: false
pre: " <b> 3.6. </b> "
---

*by Philip Chen and Varun Selvaraj*
*on 01 JUN 2026*

Imagine a teammate who needs to find a user across thousands of accounts with only a partial email address, a last name, and a known access level. How quickly can your team respond? If your use case involves straightforward searches on standard Amazon Cognito attributes, the built-in `ListUsers` API is likely all you need. But for advanced scenarios involving custom attributes, fuzzy matching, complex filtering, and sub-second response times, a dedicated search layer is the right investment.

Amazon Cognito provides robust user authentication and management capabilities for modern applications. As applications scale, development teams typically implement advanced search functionality to find users by partial email match, segment group membership, or audit across multiple custom attributes.

In this post, we show how to build a comprehensive scalable user search layer on top of Amazon Cognito using AWS Lambda, Amazon DynamoDB, and Amazon OpenSearch Service.

## Solution overview

This solution extends Amazon Cognito with advanced search capabilities using AWS Lambda, Amazon DynamoDB, and Amazon OpenSearch Serverless.

Key capabilities:
- **Multiple search types**: Exact match, prefix match, and fuzzy search
- **Complex filtering**: Query across email, phone, groups, and registration date simultaneously
- **High performance**: Sub-second response times at any scale
- **Automatic synchronization**: Real-time updates as users authenticate or update profiles
- **API-driven**: RESTful API with pagination support

The architecture uses Cognito Lambda triggers to capture user data during authentication, stores it in DynamoDB, and indexes it in OpenSearch Serverless through DynamoDB Streams. The following architecture diagram illustrates how these components work together.

![Figure 1: Solution architecture for Searchable Cognito Users](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/Screenshot-2026-05-22-at-10.19.09%E2%80%AFAM-1024x652.png)
*Figure 1: Solution architecture for Searchable Cognito Users*

## Walkthrough

The solution architecture demonstrates two flows: Ingestion flow and Search flow.

### Ingestion flow

The ingestion flow captures and indexes user data through two paths: Cognito Lambda triggers and AWS CloudTrail. Together, these paths maintain synchronization between the search index and Cognito without requiring manual intervention or scheduled batch jobs.

#### 1. Cognito Lambda triggers
This path captures user data during authentication events using a Cognito trigger Lambda function that handles two trigger types: Post-confirmation and Pre-token generation. The post-confirmation trigger creates the initial user record on sign-up, while the pre-token generation trigger tracks login activity and app client information on each subsequent authentication. The pre-token generation trigger also provides access to the user’s group membership in the event payload, which is indexed as a searchable field. The flow operates through the following steps:
1. **Client initiates sign-up or login** — User submits authentication request to Amazon Cognito.
2. **Post-confirmation trigger** — On sign-up, Cognito invokes the Cognito trigger Lambda which creates the initial user record in the DynamoDB user table with profile attributes (email, name, groups).
3. **Pre-token generation trigger** — On each login, Cognito invokes the Cognito trigger Lambda which updates the user’s login timestamp and app client information in the DynamoDB user table.
4. **Stream processing** — DynamoDB Streams detects the new or updated record and triggers the OSS ingest Lambda.
5. **Index updated** — OSS ingest Lambda processes the stream event and indexes the user data in OpenSearch Serverless.

Note: The Cognito Lambda triggers are deployed in a VPC. Cognito enforces a 5-second timeout on trigger functions. If you’re extending these triggers with additional functionality or already using post-confirmation or pre-token generation triggers, ensure the combined execution time stays well within this limit. Consider provisioned concurrency if cold starts are a concern.

![Figure 2: User Data Ingestion via Cognito Lambda Triggers](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/Screenshot-2026-05-22-at-10.23.12%E2%80%AFAM-1024x646.png)
*Figure 2: User Data Ingestion via Cognito Lambda Triggers*

#### 2. CloudTrail
This path captures admin-initiated user changes that occur outside the authentication flow, such as creating users using the Cognito console or CLI. These actions don’t trigger Cognito Lambda triggers, so CloudTrail and EventBridge bridge the gap. The flow operates through the following steps:
1. **Admin action performed** — User performs an admin action in Amazon Cognito (for example, create user, update attributes, add to group, disable user).
2. **API call logged** — AWS CloudTrail captures the Cognito admin API call.
3. **EventBridge rule matched** — An Amazon EventBridge rule matches the Cognito admin event.
4. **CloudTrail event Lambda invoked** — EventBridge invokes the CloudTrail event consumption Lambda, which reads the current user state from Cognito and upserts the profile in the DynamoDB user table.
5. **Stream change event** — DynamoDB Streams emits the change event.
6. **Invoke OSS Lambda** — The stream event triggers the OSS ingest Lambda.
7. **Index user data** — OSS ingest Lambda indexes the updated user data in OpenSearch Serverless.

![Figure 3: User Data Ingestion via CloudTrail](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/Screenshot-2026-05-22-at-10.24.26%E2%80%AFAM-1024x360.png)
*Figure 3: User Data Ingestion via CloudTrail*

![Figure 4: Data model for indexed user attributes in Amazon DynamoDB](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/Screenshot-2026-05-22-at-10.26.45%E2%80%AFAM-1024x468.png)
*Figure 4: Data model for indexed user attributes in Amazon DynamoDB*

### Search flow

With the search flow, authorized users can query the indexed user directory:
1. **Query submission** — Authenticated user submits search query through the UI.
2. **Request validation** — API Gateway receives the request with the Cognito JWT token and validates it using the Cognito authorizer.
3. **Search execution** — Upon successful validation, the search Lambda function is invoked with the search parameters.
4. **OpenSearch query** — Lambda assumes a read-only role for OpenSearch Service access and executes the query against the OpenSearch Serverless index.
5. **Results returned** — Lambda formats and returns the query results to the frontend, where the UI displays them in a paginated format.

![Figure 5: Search Flow Sequence Diagram](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/Screenshot-2026-05-22-at-10.27.49%E2%80%AFAM-1024x602.png)
*Figure 5: Search Flow Sequence Diagram*

![Figure 6: Demo UI user search integration on multiple properties](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/Screenshot-2026-05-22-at-10.28.40%E2%80%AFAM-1024x583.png)
*Figure 6: Demo UI user search integration on multiple properties*

![Figure 7: Demo UI user search integration on auto-suggest](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/Screenshot-2026-05-22-at-10.29.35%E2%80%AFAM-1024x581.png)
*Figure 7: Demo UI user search integration on auto-suggest*

## Try it yourself

Ready to see this solution in action? The repository includes everything you need to deploy a complete working implementation in your own AWS environment.

The source code for this solution is available on GitHub at:
https://github.com/aws-samples/sample-user-search-layer-for-cognito

The repository includes everything you need: AWS CDK infrastructure code, Lambda function implementations, a React frontend, and documentation. You can have a fully functional searchable user directory running in your account in under 20 minutes. When you’re finished testing, clean up all resources to avoid ongoing charges.

## Conclusion

In this post, you learned how to extend Amazon Cognito with advanced search capabilities. By combining OpenSearch Serverless, DynamoDB Streams, and Lambda functions, you can build a scalable, event-driven architecture that automatically maintains a searchable user directory with sub-second query performance.

This pattern unlocks powerful use cases: support teams can quickly locate users across thousands of accounts, administrators can segment users by group membership for targeted communications, and compliance teams can audit user attributes with complex filtering.
