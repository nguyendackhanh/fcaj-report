---
title : "Tạo CloudFormation stack"
date: 2026-06-30
weight : 2
chapter : false
pre : " <b> 5.3.2. </b> "
---

#### Tạo stack

1. Mở dịch vụ **CloudFormation** trên AWS Console.
2. Chọn **Create stack** và chọn **With new resources (standard)**.
3. Ở phần **Specify template**, chọn **Upload a template file**.
4. Chọn file `template.yaml` đã cập nhật và bấm **Next**.
5. Ở phần **Specify stack details**, nhập:
   - **Stack name:** `EventApp-Backend-System`
   - **BillingAlertEmail:** email cá nhân
6. Giữ nguyên cấu hình mặc định ở **Configure stack options** và bấm **Next**.
7. Ở bước **Review**, cuộn xuống cuối trang và tick vào checkbox xác nhận cho phép tạo IAM resources.
8. Bấm **Submit**.

#### Chờ triển khai hoàn tất

CloudFormation sẽ tạo các tài nguyên backend. Quá trình này thường mất vài phút. Refresh tab Events cho đến khi trạng thái stack chuyển thành **CREATE_COMPLETE**.

![CloudFormation stack hoàn tất](/images/5-Workshop/event-portal/04-cloudformation-complete.png)

#### Lấy outputs

Sau khi stack tạo xong, mở tab **Outputs** và copy các giá trị sau:

- **ApiUrl**: Đường dẫn Backend API.
- **UserPoolId**: Cognito User Pool ID.
- **UserPoolClientId**: Cognito app client ID.
- **FrontendBucketName**: Tên S3 bucket dùng để host frontend website.

Các giá trị này sẽ được dùng khi cấu hình và triển khai frontend.