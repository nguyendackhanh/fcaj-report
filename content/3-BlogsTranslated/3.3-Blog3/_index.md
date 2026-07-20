---
title: "Blog 3: Building highly available Oracle databases with Amazon FSx for NetApp ONTAP"
date: 2026-06-03
weight: 3
chapter: false
pre: " <b> 3.3. </b> "
---


*by Vignyanand Penumatcha and Sharath Lingareddy*
*on 03 JUN 2026*

Oracle databases power mission-critical enterprise applications, making their continuous availability essential for business operations. Traditional Oracle high availability (HA) solutions require complex clustering software, expensive shared storage arrays, and specialized database administration teams. These conventional approaches often introduce single points of failure while demanding significant operational overhead.

Modern cloud architectures offer a transformative approach that combines Amazon FSx for NetApp ONTAP (FSxN) with Amazon EC2 Auto Scaling groups, automated AMI creation, AWS Lambda-driven orchestration, and AWS Systems Manager Parameter Store (SSM Parameter). This solution removes traditional Oracle HA complexities while delivering enterprise-grade availability, automated recovery, and makes sure new instances launch with the latest Oracle configuration.

This post shows how to build a highly available Oracle database architecture using FSxN shared storage, Auto Scaling groups with dynamic AMI updates, and serverless orchestration to help reduce recovery times with current configurations.

## Solution overview

The solution uses multiple AWS services working together to create a comprehensive high availability architecture. FSxN Multi-AZ provides persistent shared storage spanning availability zones for Oracle database files, software, and configurations, so that data remains accessible when EC2 instances are replaced. Auto Scaling groups deliver automated instance lifecycle management with the latest AMI configurations, so failed instances are quickly replaced with identical configurations that can immediately access the existing Oracle database files on FSxN. AWS Backup creates AMIs that capture the latest Oracle host configurations including patches and settings, preserving the complete server state for consistent deployments. AWS Lambda extracts the AMI ID from backup recovery points and updates the SSM Parameter, orchestrating the entire configuration management workflow. Systems Manager Parameter Store stores the current AMI ID for Auto Scaling group launch templates, so new instances always launch with the most recent configuration and can immediately connect to the Oracle database on shared storage.

The following diagram shows the complete architecture with all AWS services and their interactions:

![AWS architecture diagram](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/archblog-1212-image-1.png)

Key benefits include:
- **Recovery Time Objective (RTO)**: Can help achieve 2–5 minutes with latest Oracle configuration
- **Recovery Point Objective (RPO)**: Near-zero through synchronous Multi-AZ replication
- **Configuration consistency**: New instances launch with identical Oracle host setup
- **Automated AMI management**: Scheduled AMI creation with Parameter Store updates

## Walkthrough

This walkthrough demonstrates implementing Oracle HA using Amazon FSx for NetApp ONTAP shared storage, AWS Backup-driven AMI creation, Lambda orchestration, and Auto Scaling groups with Parameter Store integration for configuration consistency and automated failover.

### Prerequisites

For this walkthrough, you should have the following prerequisites:
- An AWS account with appropriate permissions for Amazon FSx, Auto Scaling, EC2, Lambda, and Systems Manager
- A VPC with subnets in at least two Availability Zones
- Oracle database software (Keep in mind that customers are responsible for their own Oracle licensing compliance.)
- An EC2 instance with Oracle database installed and configured
- AWS Identity and Access Management (IAM) roles for AMI creation and cross-service communication
- Basic knowledge of Oracle database administration and AWS automation

### Assumptions

This post is a conceptual illustration of the architecture. Your specific implementation will vary based on your VPC layout, Oracle version, storage requirements, and organizational security policies.

We assume the reader is familiar with:
- Creating and configuring Amazon FSx for NetApp ONTAP file systems through the AWS console
- iSCSI concepts including initiators, targets, and multipath I/O
- Oracle database startup and shutdown procedures
- AWS Backup, Lambda, and Auto Scaling group fundamentals

### Step 1: Create an Amazon FSx for NetApp ONTAP file system

FSxN Multi-AZ provides the persistent shared storage foundation for this architecture. Unlike Amazon Elastic Block Store (Amazon EBS) volumes, which are bound to a single AZ, FSxN Multi-AZ replicates data synchronously across two AZs with automatic failover. This means that when an EC2 instance is replaced, the new instance can immediately access the existing Oracle database files without restoring from backup.

To create the file system, navigate to the Amazon FSx console and select Amazon FSx for NetApp ONTAP as the file system type. The critical configuration choice is selecting Multi-AZ deployment, which places an active file server in one AZ and a standby in another.

![Amazon FSx console](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/archblog-1212-image-2.png)
*FSxN console showing Multi-AZ deployment type selection with preferred and standby subnets in separate availability zones.*

After the file system is created, you need to set up a Storage Virtual Machine (SVM), which acts as a logical storage container providing data access to your Oracle instances. The SVM creation is done from the FSx console under your file system’s details. With the SVM in place, the next step is configuring iSCSI access. FSxN exposes iSCSI endpoints—these are IP addresses (one per AZ) that your EC2 instances use to connect to the storage over the iSCSI protocol.

![Amazon FSx Storage Virtual Machine](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/archblog-1212-image-3.png)
*SVM Endpoints tab showing iSCSI endpoint IP addresses for each availability zone.*

The iSCSI setup involves creating iGroups and LUNs through the NetApp ONTAP CLI. On the EC2 side, you configure the iSCSI initiator to discover and connect to the FSxN endpoints, then mount the resulting block devices. Using multipath I/O with both endpoints makes sure that Oracle data remains accessible even during an AZ failover.

A dedicated security group is required for FSxN access. At minimum, the security group must allow inbound traffic on ports 111 (NFS portmapper), 635 (NFS mountd), 2049 (NFS), 3260 (iSCSI), 4045–4046 (NFS lock), 443 (HTTPS for management), and 22 (SSH for ONTAP CLI). Restrict the source to only your Oracle EC2 instances’ security group.

### Step 2: Set up AWS Backup for EC2 instance protection

AWS Backup captures the complete state of your Oracle EC2 instance. The key design choice here is using tag-based resource selection rather than specifying instance IDs directly. Because Auto Scaling groups replace instances, tag-based selection makes sure that any new instance with the correct tags are automatically included in the backup plan. Configure a backup plan with a frequency appropriate for your environment and set the resource assignment to select EC2 instances matching your application tag.

![AWS Backup console](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/archblog-1212-image-4.png)
*AWS Backup resource assignment configured with tag-based selection.*

### Step 3: Configure Lambda for AMI management

When AWS Backup completes an EC2 backup, it creates an AMI as the recovery point. An Amazon EventBridge rule detects this completion event and triggers a Lambda function. The function extracts the AMI ID from the backup recovery point, updates the SSM Parameter Store parameter with the new AMI ID, and cleans up older AMIs to control storage costs.

![AWS Lambda function](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/archblog-1212-image-5.png)
*Lambda function overview.*

This event-driven approach means the latest AMI is available without manual intervention. The Lambda function needs IAM permissions for EC2, SSM, and Backup.

![Amazon EventBridge rule](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/archblog-1212-image-6.png)
*EventBridge rule configured to match AWS Backup job completion events.*

### Step 4: Configure the Systems Manager Parameter Store

The SSM Parameter Store holds the current AMI ID that the Auto Scaling group’s launch template references. The parameter is created with the `aws:ec2:image` data type, which enables the launch template’s `resolve:ssm:` functionality.

![AWS Systems Manager Parameter Store](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/archblog-1212-image-7.png)
*SSM Parameter Store showing the /oracle/ec2/ami-id parameter.*

When Lambda updates this parameter after each backup cycle, the next instance launched by the Auto Scaling group will automatically use the latest AMI. This removes the operational burden of manually updating launch template versions.

### Step 5: Set up an Auto Scaling Group with dynamic AMI

The launch template references the SSM parameter using the `resolve:ssm:` prefix for the AMI ID field. This is the mechanism that ties the entire automation pipeline together.

![EC2 Launch Template](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/archblog-1212-image-8.png)
*Launch template AMI configuration showing the ‘resolve:ssm:’ prefix.*

The Auto Scaling group is configured with minimum, maximum, and desired capacity all set to 1. This is not traditional auto-scaling, it’s a self-healing pattern. The sole purpose is to detect when the Oracle instance becomes unhealthy and automatically launch a replacement. The health check grace period should be set to at least 300 seconds to allow Oracle sufficient time to start.

The launch template also includes a User Data script that runs on each new instance. This script configures the iSCSI initiator, discovers and connects to the FSxN endpoints, mounts the Oracle data volumes, and starts the Oracle database through a systemd service.

![EC2 Auto Scaling group](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/archblog-1212-image-9.png)
*Auto Scaling group configured with min=max=desired=1.*

### Test the complete workflow

To validate the architecture, simulate an instance failure by terminating the current Oracle EC2 instance.
The expected sequence is:
1. The Auto Scaling group detects the instance is unhealthy (within approximately 30 seconds)
2. A new instance launches from the latest AMI resolved from Parameter Store (approximately 2 minutes)
3. The User Data script connects to FSxN using iSCSI and starts Oracle (approximately 2–3 minutes)
4. The Oracle database is available and accepting connections (total elapsed: approximately 5 minutes)

![Auto Scaling group Activity History](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/archblog-1212-image-10.png)
*Auto Scaling group Activity History showing the self-healing sequence.*

The new instance automatically inherits the application tags from the Auto Scaling group, which means AWS Backup includes it in the next backup cycle without manual configuration.

## Cleaning up

To avoid incurring future charges, delete the resources:
- Delete Lambda functions and EventBridge rules
- Remove Parameters from Systems Manager Parameter Store
- Delete AWS Backup plans and backup vault
- Deregister created AMIs
- Terminate Auto Scaling group instances
- Delete the Amazon FSx for NetApp ONTAP file system

## Conclusion

This architecture facilitates Oracle high availability with configuration consistency by combining FSxN persistent shared storage with automated AMI management and AWS Backup protection. The Lambda-driven AMI management from backup recovery points and Parameter Store integration helps make sure that replacement instances launched by Auto Scaling groups always use the latest Oracle host configuration and can immediately connect to the existing Oracle database files stored on FSxN. Replacements occur only when health checks fail. Organizations can target high availability while maintaining configuration consistency across instance replacements.
