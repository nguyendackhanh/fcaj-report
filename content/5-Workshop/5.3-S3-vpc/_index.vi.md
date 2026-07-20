---
title : "Triển khai backend bằng CloudFormation"
date: 2026-06-30
weight : 3
chapter : false
pre : " <b> 5.3. </b> "
---

#### Tổng quan

Trong phần này, ta triển khai toàn bộ backend system bằng một CloudFormation stack. Stack sẽ tạo các tài nguyên serverless chính cho dự án Event Portal, bao gồm DynamoDB tables, Cognito resources, Lambda functions và API Gateway.

Trước khi tạo stack, cần cập nhật tất cả giá trị `CodeUri: dist/` trong file `template.yaml` để trỏ đến backend package đã upload lên Amazon S3.

#### Nội dung

- [Cập nhật template.yaml](5.3.1-create-gwe/)
- [Tạo CloudFormation stack và lấy outputs](5.3.2-test-gwe/)

#### Kết quả triển khai

Khi stack chuyển sang trạng thái **CREATE_COMPLETE**, backend đã được triển khai hoàn tất.

![CloudFormation stack hoàn tất](/images/5-Workshop/event-portal/04-cloudformation-complete.png)