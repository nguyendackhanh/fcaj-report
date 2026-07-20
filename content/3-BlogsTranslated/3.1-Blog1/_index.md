---
title: "Blog 1: How Bedrock Streaming optimizes its AWS costs"
date: 2026-06-02
weight: 1
chapter: false
pre: " <b> 3.1. </b> "
---


*by Pascal Martin, Iryna Oliinykova, and Ramzi Trabelsi*
*on 02 JUN 2026*

## Introduction

Optimizing costs represents a major challenge for video streaming companies. This challenge intensifies with constantly increasing traffic and growing solution complexity. With a systematic cloud financial operations (FinOps) strategy, organizations can turn each technical decision into an opportunity for cost optimization, achieving substantial savings.

Bedrock Streaming perfectly illustrates this approach. The company hosts their solutions on Amazon Web Services (AWS) to serve major European broadcasters such as M6+, Videoland, and RTL+. With an AWS budget of several million dollars per year, each percentage point of optimization generates considerable savings. Managing costs is particularly challenging because their web traffic varies throughout the day, with peaks during sports events and popular TV shows.

Since beginning their AWS migration in 2018, Bedrock Streaming has developed an approach that goes beyond traditional reservation strategies. The company applies a multi-axis FinOps strategy involving Kubernetes worker nodes that run 100% on Amazon Elastic Compute Cloud (Amazon EC2) Spot Instances, AWS Graviton Processors, the rationalization of AWS API calls, video streaming optimization, and constant attention to data storage. This FinOps approach transforms every technical decision into a cloud cost optimization lever.

## Compute and managed services optimization

Bedrock Streaming optimizes its AWS compute costs using two main strategies. First, the company deploys instance reservations for managed services such as Amazon Relational Database Service (Amazon RDS), Amazon ElastiCache, and Amazon OpenSearch Service, and capacity reservations for Amazon DynamoDB. Savings Plans represent less than 5% of Amazon EC2 usage, also covering AWS Lambda and AWS Fargate services.

The second strategy specifically targets Amazon EC2, where Spot Instances replace traditional reservations. This approach meets Bedrock Streaming’s autoscaling needs, where traffic fluctuates by a factor of 10 between morning low points and evening peaks. The production infrastructure, including Kubernetes worker nodes, runs on Spot Instances with automatic failover to on-demand instances during periods of limited spot capacity.

AWS can reclaim Spot Instances at any time with 2 minutes of advance notice. Bedrock Streaming has implemented a termination handler, which is triggered when an instance signals it will be reclaimed. The handler immediately starts a new instance while stopping applications deployed on the old node.

The team has reduced the startup time of new instances thanks to custom Amazon Machine Images (AMIs) that incorporate Kubernetes components and base Docker images required by their applications. They use more than 10 instance types in each of the three Availability Zones to maximize availability. This approach means Bedrock Streaming can achieve 100% Spot Instances for Kubernetes.

For managed services such as Amazon RDS, Amazon ElastiCache, or Amazon OpenSearch Service where elasticity doesn’t meet Bedrock Streaming’s needs, the teams begin by deploying their new projects with oversized instances, analyze their behavior under real load for a few days, then resize to the optimal size. The additional cost is minor, and this method quickly leads to optimal cost while avoiding the risks of undersizing. The team makes reservations later during semi-annual global reservations reviews.

The adoption of AWS Graviton Processors represents another effective optimization pillar. The teams began by migrating some Amazon Elastic MapReduce (Amazon EMR) jobs. The largest savings came during the migration of Amazon RDS, Amazon ElastiCache, and Amazon OpenSearch Service instances to AWS Graviton: They achieved a 15%–20% savings with a quick configuration change. The final step, which is underway as of this writing, involves migrating the few non-Spot Instance Kubernetes nodes (the master nodes).

## Storage and data services optimization

Storage with Amazon Simple Storage Service (Amazon S3) forms the foundation of Bedrock Streaming’s infrastructure for hosting their video library. The company uses the advanced features of Amazon S3, including different storage classes, automatic transition policies, Intelligent Tiering for buckets with variable usage, and automated object lifecycle management.

Efficient storage management extends beyond Amazon S3 at Bedrock Streaming. The cloud storage requires increased vigilance over resource accumulation, such as rigorous tracking of obsolete AMIs and unused snapshots.

Bedrock Streaming’s experience with Amazon Elastic Container Registry (Amazon ECR) illustrates this issue. During their migration to AWS and Kubernetes, the company’s Amazon ECR costs increased significantly because of the accumulation of Docker images generated by daily deployments. Enabling the automatic purge feature for old images in Amazon ECR meant Bedrock Streaming could control these costs.

Amazon DynamoDB is one of the solutions Bedrock Streaming chose for their critical workloads. Amazon DynamoDB cost optimization relies on two main axes: query management and data storage. The data storage represents a major lever in cost control.

The company identifies that storage for certain tables generates costs higher than those of queries. To address this issue, Bedrock Streaming uses the Amazon DynamoDB time to live (TTL) feature, which permits automatic expiration of obsolete data. This approach not only optimizes direct storage costs but also reduces costs associated with table backups.

For Amazon DynamoDB tables with a large volume of rarely accessed data, the standard Infrequent Access storage class represents a relevant optimization option. This class becomes particularly advantageous when a table’s storage cost exceeds 50% of the cost related to read and write operations.

## Network cost optimization

Network cost optimization is a major focus at Bedrock Streaming. The implementation of virtual private cloud (VPC) endpoints for Amazon S3 and Amazon DynamoDB eliminates transit costs using AWS Network Address Translation (NAT) Gateway. It generates significant savings on high-traffic services.

The company also optimizes their inter-Availability Zone transfer costs through targeted architectural changes. The video-on-demand streaming solution illustrates this approach. The first version, which was deployed across three Availability Zones, involved video segment transfers between zones. The new architecture adopts a single-zone approach where each request is processed entirely within its entry Availability Zone, eliminating inter-Availability Zone data transfers.

This new architecture maintains the same level of resilience as the previous one. The difference is its operating mode: Rather than handling requests distributed across three Availability Zones, the solution processes each request entirely within its entry zone. This approach eliminates inter-Availability Zone transfer costs while preserving high availability.

## Lesser-known aspects of cost optimization

As their AWS deployment progressed in 2018–2019, Bedrock Streaming identified unexpected costs on certain projects. A significant case involved an API for downloading images stored on S3, where API costs exceeded storage costs.

Code analysis revealed that the API was unnecessarily checking the existence of each level in the file path hierarchy, an operation redundant in the S3 environment. The team replaced these checks with direct image access and implemented 404 error handling. As a result, the team achieved three key benefits: preserved functionality, reduced latency, and lower API costs.

The use of Amazon Simple Queue Service (Amazon SQS) at Bedrock Streaming represents a significant case. The company adopted a batch processing approach for messages rather than individual processing and reduced their deletion operation costs by 66%.

## Logs and metrics management

Bedrock Streaming favors a centralized approach for monitoring their metrics. Rather than directly using the Amazon CloudWatch console, the company uses a system for exporting metrics to a Prometheus stack. A dedicated Amazon CloudWatch exporter performs an export that periodically queries the Amazon CloudWatch GetMetricStatistics and GetMetricData APIs.

Initially, the exporter was configured to collect a wide range of metrics as a precautionary measure. Bedrock Streaming optimizes the configuration by precisely aligning collected metrics with those used in Grafana. This rationalization reduces API call costs by two-and-a-half times.

Log management represents another cost optimization axis at Bedrock Streaming. The company applies the dual strategy of rationalizing collected information and implementing an adapted retention policy. For logs requiring extended retention, particularly for compliance purposes, Amazon CloudWatch Logs Infrequent Access enables up to 50% reduction in ingestion and storage costs.

## Understanding how AWS services operate

Cost optimization requires a deep understanding of the specificities of each AWS service, both at functional and financial levels.

AWS Step Functions particularly illustrates this principle. Bedrock Streaming opts for express mode rather than the default standard mode. This choice significantly reduces the service’s financial impact in one of their workflow projects.

Amazon DynamoDB cost optimization at Bedrock Streaming relies on careful selection of the capacity mode for each table. Two main options are considered:
- **On-demand mode**: Suitable for tables with highly variable and unpredictable traffic.
- **Provisioned mode with autoscaling**: More efficient for tables with predictable traffic patterns.

The choice between these two modes is made table by table based on the specific characteristics of each workload. Provisioned mode offers an additional advantage in the ability to make capacity reservations, facilitating additional cost reductions in the long term.

Bedrock Streaming follows a proven methodology for their new Amazon DynamoDB projects. The company systematically starts with on-demand mode to support application performance and stability. After an observation period of a few days and analysis of usage patterns, they evaluate tables for potential migration to provisioned mode when it presents an economic advantage.

## A technical and cultural approach to cost optimization

AWS cost optimization must be part of a global reflection on infrastructure return on investment (ROI). The goal is to achieve an optimal balance between costs and meeting operational needs. Bedrock Streaming illustrates this approach by limiting the use of Amazon EC2 T instance family (burstable performance) in production, favoring performance stability despite higher costs.

Bedrock Streaming uses a cost tracking and optimization strategy based on three complementary tools:
- **AWS Cost Explorer**: Used for detailed expense analysis.
- **AWS Cost Anomaly Detection**: A machine learning system that quickly alerts to unexpected cost variations.
- **AWS Cost Optimization Hub**: Provides a centralized view of optimization opportunities.

Although infrastructure teams manage tools such as reservations and Savings Plans, effective cost optimization requires broader involvement. All teams and business units need to recognize that managing hosting costs falls within their responsibilities and is not solely the infrastructure team’s domain.

## Conclusion

By combining 100% Amazon EC2 Spot Instances with Kubernetes worker nodes, using AWS Graviton Processors, and fine-tuning data services such as Amazon DynamoDB, Bedrock Streaming achieves substantial savings on a multimillion-dollar annual cloud budget. These techniques extend beyond traditional instance reservation approaches, including AWS API call rationalization, inter-Availability Zone transfer optimization, and intelligent use of storage classes.

The optimization strategy in the video streaming sector is transferable to many industries. Regardless of the load profile, you can activate several optimization levers. Start your own optimization journey by activating AWS Cost Anomaly Detection today. As Bedrock Streaming demonstrates, every percentage point of optimization counts.
