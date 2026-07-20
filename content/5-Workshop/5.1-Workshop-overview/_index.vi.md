---
title : "Tổng quan workshop"
date: 2026-06-30
weight : 1 
chapter : false
pre : " <b> 5.1. </b> "
---

#### Triển khai nhanh bằng CloudFormation

Mục tiêu của workshop này là triển khai dự án Event Portal với ít thao tác thủ công hơn bằng cách sử dụng **AWS CloudFormation**. File `template.yaml` trong source code backend mô tả các tài nguyên hạ tầng cần thiết, bao gồm DynamoDB, Cognito, Lambda functions, API Gateway và S3 bucket dành cho frontend.

Với phương pháp này, quy trình triển khai được rút gọn như sau:

1. Đóng gói backend code và upload lên Amazon S3.
2. Cập nhật `template.yaml` để các Lambda functions lấy được backend package từ S3.
3. Upload template lên AWS CloudFormation và tạo backend stack.
4. Copy các thông số Outputs của CloudFormation và cấu hình frontend.
5. Build frontend và upload các file tĩnh đã sinh ra lên frontend S3 bucket.

#### Vì sao dùng Infrastructure as Code?

- Giảm các thao tác thủ công trên AWS Console.
- Giữ kiến trúc AWS nhất quán và có thể triển khai lại.
- Dễ rebuild backend khi cần.
- Hạn chế sai lệch cấu hình giữa môi trường phát triển và triển khai.
- Giúp nhóm tài liệu hóa hạ tầng thực tế ngay trong source code.

#### Các dịch vụ AWS sử dụng

- **Amazon S3**: Lưu trữ file code backend đã đóng gói và dùng để host tĩnh giao diện web frontend.
- **AWS CloudFormation**: Dịch vụ Infrastructure as Code (IaC) giúp tự động hóa quá trình triển khai hệ thống backend thông qua template.
- **AWS Lambda**: Dịch vụ Serverless compute để chạy logic xử lý backend mà không cần cấu hình máy chủ.
- **Amazon API Gateway**: Đóng vai trò là cửa ngõ, cung cấp và quản lý RESTful API cho frontend kết nối.
- **Amazon DynamoDB**: Cơ sở dữ liệu NoSQL với khả năng mở rộng cao và độ trễ thấp, lưu trữ dữ liệu của ứng dụng.
- **Amazon Cognito**: Cung cấp giải pháp xác thực và quản lý tài khoản người dùng một cách an toàn.

#### Kiến trúc hoàn chỉnh

Sau khi hoàn thành, hệ thống gồm frontend tĩnh được host trên S3, REST APIs thông qua API Gateway, backend logic chạy bằng Lambda, dữ liệu lưu trong DynamoDB và xác thực người dùng bằng Cognito.

![Architecture](/images/architect.jpg)