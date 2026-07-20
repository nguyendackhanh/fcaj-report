---
title: "Blog 2: Đạt được quyền truy cập đặc quyền tối thiểu cho Amazon Route 53 Profiles"
date: 2026-06-04
weight: 2
chapter: false
pre: " <b> 3.2. </b> "
---


*bởi Aanchal Agrawal và Anushree Shetty*
*vào ngày 04 Tháng 6, 2026*

Nếu bạn quản lý DNS trên nhiều tài khoản AWS với Amazon Route 53 Profiles, việc đạt được quyền truy cập đặc quyền tối thiểu cho mỗi nhóm có thể là một thách thức. Nếu không có các quyền chi tiết, một nhóm có thể vô tình sửa đổi tài nguyên của nhóm khác, dẫn đến các lỗ hổng quản trị, rủi ro bảo mật và làm chậm quá trình áp dụng quản lý DNS tập trung. Các quyền AWS Identity and Access Management (AWS IAM) chi tiết mới cho Amazon Route 53 Profiles giải quyết vấn đề này bằng cách cho phép bạn xác định các kiểm soát truy cập ở cấp độ tài nguyên và hành động. Mỗi nhóm chỉ nhận được các quyền họ cần, giúp giảm rủi ro và tăng hiệu quả hoạt động.

Trong bài viết này, bạn sẽ tìm hiểu cách áp dụng các chính sách IAM chi tiết cho Amazon Route 53 Profiles nhằm giới hạn các quyền. Các quyền được giới hạn bởi loại tài nguyên, ARN của tài nguyên, tên miền, mức độ ưu tiên của nhóm quy tắc tường lửa và ID của Amazon Virtual Private Cloud (Amazon VPC). Bạn sẽ đi qua ba kịch bản thực tế giới hạn quyền cho các nhóm ứng dụng, nhóm bảo mật và kỹ sư mạng bằng các chính sách IAM với các từ khóa điều kiện (condition keys) `route53profiles` mới. Đến cuối bài, bạn sẽ có các mẫu chính sách IAM có thể tái sử dụng giúp thực thi quyền truy cập đặc quyền tối thiểu cho việc quản lý DNS đa tài khoản.

## Điều kiện tiên quyết

Để thực hiện theo hướng dẫn này, bạn cần có:
- Một tài khoản AWS với quyền tạo và quản lý các chính sách IAM.
- Sự quen thuộc ở mức trung bình với AWS IAM và Amazon Route 53.
- Một Route 53 Profile hiện có (hoặc khả năng tạo một Profile).
- Quen thuộc với AWS Resource Access Manager (AWS RAM) và kiến trúc đa tài khoản (hữu ích nhưng không bắt buộc).
- (Tùy chọn) Thiết lập đa tài khoản với AWS RAM sharing được định cấu hình để kiểm tra các kịch bản liên tài khoản.

## Amazon Route 53 Profiles là gì?

Với Amazon Route 53 Profiles, bạn có thể xác định một cấu hình DNS tiêu chuẩn và áp dụng nó một cách nhất quán trên nhiều VPC và tài khoản AWS. Một Profile gói gọn các liên kết private hosted zone, các quy tắc Amazon Route 53 Resolver (chuyển tiếp và quy tắc hệ thống), các nhóm quy tắc DNS Firewall, cấu hình Resolver Query Logging, các liên kết interface VPC endpoint, và các cấu hình VPC (bao gồm tra cứu DNS ngược cho Resolver Rules, chế độ lỗi DNS Firewall, và cấu hình xác thực DNSSEC).

Bạn chỉ cần định nghĩa cài đặt DNS một lần trong Profile, chia sẻ nó giữa các tài khoản thông qua AWS RAM và liên kết nó với các VPC. Khi bạn cập nhật Profile, các thay đổi đó tự động truyền đến các VPC được liên kết, giúp giảm thiểu cấu hình thủ công cho mỗi VPC và giảm trôi dạt cấu hình.

## Thách thức: Quản lý quyền DNS ở quy mô lớn

Trước đây, Route 53 Profiles chỉ hỗ trợ các quyền IAM ở cấp độ hành động API (API-action level). Điều này cho phép bạn cho phép hoặc từ chối các hành động như `AssociateResourceToProfile` nhưng không thể giới hạn loại tài nguyên, các tài nguyên cụ thể, hoặc VPC mà một đối tượng có thể tác động. Điều này có nghĩa là:
- Một nhóm ứng dụng cần liên kết với private hosted zone cũng có thể thêm/xóa các nhóm quy tắc DNS Firewall.
- Một nhóm bảo mật quản lý chính sách DNS Firewall có thể vô tình sửa đổi các quy tắc Resolver.
- Một kỹ sư mạng liên kết các VPC với Profile có quyền ngầm định sửa đổi các tài nguyên bên trong Profile đó.

Việc giới hạn quyền thông qua các khóa điều kiện `route53profiles` mới bao gồm:
- `route53profiles:ResourceTypes`
- `route53profiles:ResourceArns`
- `route53profiles:HostedZoneDomains`
- `route53profiles:ResolverRuleDomains`
- `route53profiles:FirewallRuleGroupPriority`
- `route53profiles:ResourceIds`

## Kiến trúc: Ủy quyền DNS đa tài khoản

Hãy xem xét kiến trúc doanh nghiệp với một tài khoản trung tâm mạng sở hữu Route 53 Profile và chia sẻ qua AWS RAM cho các nhóm:
1. Nhóm ứng dụng: Liên kết private hosted zones.
2. Nhóm bảo mật: Quản lý các nhóm quy tắc DNS Firewall.
3. Nhóm Shared services: Quản lý liên kết VPC.

![Hình 1: Ủy quyền DNS đa tài khoản với Amazon Route 53 Profiles và quyền IAM chi tiết](https://d2908q01vomqb2.cloudfront.net/5b384ce32d8cdef02bc3a139d4cac0a22bb029e8/2026/06/04/Route53Profiles-IAMPermissions.png)

*Hình 1: Ủy quyền DNS đa tài khoản với Amazon Route 53 Profiles và quyền IAM chi tiết*

## Kịch bản 1: Nhóm ứng dụng – Chỉ liên kết và hủy liên kết private hosted zones

Nhóm ứng dụng của bạn cần liên kết private hosted zones của mình với Route 53 Profile chung. Với chính sách IAM sau, nhóm này chỉ có thể sử dụng `AssociateResourceToProfile` và `DisassociateResourceFromProfile` khi loại tài nguyên là `HostedZone`.

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

Bạn có thể giới hạn chặt chẽ hơn với khóa điều kiện `route53profiles:HostedZoneDomains` để kiểm soát các miền được phép.

## Kịch bản 2: Nhóm bảo mật – Chỉ quản lý DNS Firewall rule groups

Nhóm bảo mật đính kèm các nhóm quy tắc DNS Firewall. Chính sách sau giới hạn loại tài nguyên thành `FirewallRuleGroup` và cấp thêm quyền cập nhật mức độ ưu tiên.

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

## Kịch bản 3: Nhóm Shared services – Chỉ quản lý liên kết VPC

Quản lý VPC được thực hiện thông qua `AssociateProfile` và `DisassociateProfile`, kết hợp với khóa điều kiện `route53profiles:ResourceIds` để lọc các VPC ID cụ thể.

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

## Kết luận

Trong bài viết này, bạn đã tìm hiểu cách sử dụng các khóa điều kiện IAM chi tiết cho Amazon Route 53 Profiles để thực thi quyền truy cập đặc quyền tối thiểu. Các khóa điều kiện giúp bạn ủy quyền các hoạt động cụ thể trong Profile cho đúng nhóm phụ trách mà không cần cấp quyền dư thừa.

Hãy thử kiểm tra các chính sách của bạn trên AWS IAM Policy Simulator trước khi triển khai nhé!
