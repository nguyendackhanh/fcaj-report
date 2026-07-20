---
title: "Week 9 Worklog"
date: 2026-06-15
weight: 9
chapter: false
pre: " <b> 1.9. </b> "
---

### Week 9 Objectives:

* Set up a notification system using Amazon SNS.
* Integrate Amazon SQS to handle bulk exam submissions.
* Optimize the system's asynchronous processing flow.

### Tasks to be Implemented This Week:

| Day | Task | Start Date | Completion Date | Reference Materials |
| --- | --- | --- | --- | --- |
| 2 | - Research the operating mechanism of Amazon SNS.<br>- Set up an SNS Topic for sending notifications. | 15/06/2026 | 15/06/2026 | https://docs.aws.amazon.com/sns |
| 3 | - Create Subscriptions and test notification delivery.<br>- Test Publishing Messages from Lambda. | 16/06/2026 | 16/06/2026 | AWS Documentation |
| 4 | - Integrate Amazon SQS to receive and handle bulk exam submission requests. | 17/06/2026 | 17/06/2026 | https://docs.aws.amazon.com/sqs |
| 5 | - Build a Lambda Worker to consume Messages from SQS.<br>- Verify the Retry mechanism and Dead Letter Queue (DLQ). | 18/06/2026 | 18/06/2026 | AWS Documentation |
| 6 | - Test the entire asynchronous processing flow.<br>- Evaluate performance and resolve any arising issues. | 19/06/2026 | 19/06/2026 | Internal Documentation |

### Week 9 Achievements:

* Successfully configured the Amazon SNS Topic.
* Successfully sent and received notifications via SNS.
* Integrated Amazon SQS into the system to handle asynchronous tasks.
* Built a Lambda Worker to process Messages from the Queue.
* Gained a solid understanding of the Retry mechanism and Dead Letter Queue (DLQ).
* Enhanced concurrency handling capacity when multiple users submit exams simultaneously.