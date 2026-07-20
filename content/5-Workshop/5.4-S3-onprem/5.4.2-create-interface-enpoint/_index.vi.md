---
title : "Cấu hình quyền cho S3 bucket"
date: 2026-06-30
weight : 2
chapter : false
pre : " <b> 5.4.2. </b> "
---

#### Tắt Block Public Access

1. Mở Amazon S3.
2. Mở bucket được CloudFormation tạo, ví dụ `eventapp-frontend-333622375466-ap-southeast-1`.
3. Mở tab **Permissions**.
4. Ở phần **Block public access**, chọn **Edit**.
5. Bỏ chọn **Block all public access**.
6. Lưu thay đổi và nhập `confirm` khi AWS yêu cầu xác nhận.

![Tắt block public access](/images/5-Workshop/event-portal/05-disable-block-public-access.png)

#### Thêm bucket policy

Ở phần **Bucket policy**, thêm policy cho phép public read các object của website. Thay `<FrontendBucketName>` bằng tên bucket thực tế.

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::<FrontendBucketName>/*"
        }
    ]
}
```

Sau khi thay đúng tên bucket, lưu lại bucket policy.