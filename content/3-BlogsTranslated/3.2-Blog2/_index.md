---
title: "Blog 2: Achieve least-privilege access for Amazon Route 53 Profiles"
date: 2026-06-04
weight: 2
chapter: false
pre: " <b> 3.2. </b> "
---


*by Aanchal Agrawal and Anushree Shetty*
*on 04 JUN 2026*

If you manage DNS across multiple AWS accounts with Amazon Route 53 Profiles, achieving least-privilege access for each team can be challenging. Without fine-grained permissions, one team might inadvertently modify another team’s resources leading to governance gaps, security risks, and slower adoption of centralized DNS management. The new fine-grained AWS Identity and Access Management (AWS IAM) permissions for Amazon Route 53 Profiles solve this by letting you define access controls at the resource and action level. Each team gets only the permissions they need, which reduces risk and increases operational efficiency.

In this post, you learn how to apply fine-grained IAM policies for Amazon Route 53 Profiles that scope permissions. The permissions are scoped by resource type, resource ARN, domain name, firewall rule group priority, and Amazon Virtual Private Cloud (Amazon VPC) ID. You walk through three real-world scenarios scoping permissions for application teams, security teams, and network engineers using IAM policies with the new route53profiles condition keys. By the end, you have reusable IAM policy templates that enforce least-privilege access for multi-account DNS management.

## Prerequisites

To follow along with this walkthrough, you need the following:
- An AWS account with permissions to create and manage IAM policies
- An intermediate-level familiarity with AWS IAM and Amazon Route 53
- An existing Route 53 Profile (or the ability to create one)
- Familiarity with AWS Resource Access Manager (AWS RAM) and multi-account architecture (helpful but not required)
- (Optional) A multi-account setup with AWS RAM sharing configured for testing cross-account scenarios

## What are Amazon Route 53 Profiles?

With Amazon Route 53 Profiles, you can define a standard Route 53 DNS configuration and apply it consistently across multiple VPCs and AWS accounts. A Profile encapsulates private hosted zone associations, Amazon Route 53 Resolver rules (forwarding and system rules), DNS Firewall rule groups, Resolver Query Logging configurations, interface VPC endpoint associations, and VPC configurations (including reverse DNS lookup configuration for Resolver Rules, DNS Firewall failure mode configuration, and DNSSEC validation configuration).

You define DNS settings once in a Profile, share it across accounts using AWS RAM, and associate it with VPCs. When you update the Profile, those changes propagate automatically to associated VPCs, which reduces per-VPC manual configuration and minimizes configuration drift.

## The Challenge: Managing DNS Permissions at Scale

Previously, Route 53 Profiles supported IAM permissions only at the API-action level. This meant:
- An application team that needed to associate with a private hosted zone might also associate or disassociate DNS Firewall rule groups.
- A security team managing DNS Firewall policies might unintentionally modify Resolver rules.
- A network engineer associating VPCs with a Profile had implicit permission to modify resource associations within that Profile.

New IAM condition keys in the `route53profiles` namespace implement fine-grained permissions:
- `route53profiles:ResourceTypes`
- `route53profiles:ResourceArns`
- `route53profiles:HostedZoneDomains`
- `route53profiles:ResolverRuleDomains`
- `route53profiles:FirewallRuleGroupPriority`
- `route53profiles:ResourceIds`

## Architecture: Multi-account DNS Delegation

Consider a typical enterprise architecture with a central networking account that owns the Route 53 Profile and shares it through AWS RAM:
1. Application team account: Associate private hosted zones
2. Security team account: Manage DNS Firewall rule groups
3. Shared services team: Manage VPC associations

![Figure 1: Multi-account DNS delegation with Amazon Route 53 Profiles and fine-grained IAM permissions](https://d2908q01vomqb2.cloudfront.net/5b384ce32d8cdef02bc3a139d4cac0a22bb029e8/2026/06/04/Route53Profiles-IAMPermissions.png)

*Figure 1: Multi-account DNS delegation with Amazon Route 53 Profiles and fine-grained IAM permissions*

## Scenario 1: Application team – Associate and disassociate private hosted zones only

Your application team needs to associate its private hosted zones with a shared Route 53 Profile.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowHostedZoneAssociationOnly",
      "Effect": "Allow",
      "Action": [
        "route53profiles:AssociateResourceToProfile",
        "route53profiles:DisassociateResourceFromProfile"
      ],
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "route53profiles:ResourceTypes": "HostedZone"
        }
      }
    },
    {
      "Sid": "AllowProfileReadAccess",
      "Effect": "Allow",
      "Action": [
        "route53profiles:GetProfileResourceAssociation",
        "route53profiles:ListProfileResourceAssociations",
        "route53profiles:GetProfile",
        "route53profiles:ListProfiles"
      ],
      "Resource": "*"
    }
  ]
}
```

## Scenario 2: Security team – Manage DNS Firewall rule groups only

The security team attaches DNS Firewall rule groups to Profiles to enforce DNS filtering policies across the VPCs.

```json
{
   "Version": "2012-10-17",
   "Statement": [
       {
           "Sid": "AllowFirewallRuleGroupAssociationOnly",
           "Effect": "Allow",
           "Action": [
               "route53profiles:AssociateResourceToProfile",
               "route53profiles:DisassociateResourceFromProfile",
               "route53profiles:UpdateProfileResourceAssociation"
           ],
           "Resource": "*",
           "Condition": {
               "StringEquals": {
                   "route53profiles:ResourceTypes": "FirewallRuleGroup"
               }
           }
       },
       {
           "Sid": "AllowProfileReadAccess",
           "Effect": "Allow",
           "Action": [
               "route53profiles:GetProfileResourceAssociation",
               "route53profiles:ListProfileResourceAssociations",
               "route53profiles:GetProfile",
               "route53profiles:ListProfiles"
           ],
           "Resource": "*"
       }
   ]
}
```

## Scenario 3: Shared services team – Associate and disassociate VPCs only

VPC associations use different API actions than resource associations: `AssociateProfile` and `DisassociateProfile`.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowVpcAssociationOnly",
      "Effect": "Allow",
      "Action": [
        "route53profiles:AssociateProfile",
        "route53profiles:DisassociateProfile"
      ],
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "route53profiles:ResourceIds": "vpc-1111111111111"
        }
      }
    },
    {
      "Sid": "AllowProfileReadAccess",
      "Effect": "Allow",
      "Action": [
        "route53profiles:GetProfileAssociation",
        "route53profiles:ListProfileAssociations",
        "route53profiles:GetProfile",
        "route53profiles:ListProfiles"
      ],
      "Resource": "*"
    }
  ]
}
```

## Conclusion

In this post, you learned how to use the fine-grained AWS IAM condition keys for Amazon Route 53 Profiles to enforce least-privilege access for Profile resource and VPC associations. By using condition keys like `route53profiles:ResourceTypes`, `route53profiles:ResourceArns`, `route53profiles:FirewallRuleGroupPriority`, and `route53profiles:ResourceIds`, individually or combined in a single policy statement, you can delegate specific Profile operations to the right teams without granting unnecessary permissions.
