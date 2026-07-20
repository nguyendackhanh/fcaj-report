---
title: "Workshop"
date: 2026-06-30
weight: 5
chapter: false
pre: " <b> 5. </b> "
---



# Triển khai AWS Serverless Event Portal bằng CloudFormation

#### Tổng quan

Workshop này hướng dẫn triển khai nhanh dự án **AWS Serverless Event Portal** bằng **Infrastructure as Code (IaC)** thông qua **AWS CloudFormation**. Thay vì tạo thủ công từng database, Lambda function, API Gateway, Cognito resource và S3 bucket, ta sử dụng file `template.yaml` như một bản vẽ kiến trúc.

CloudFormation sẽ đọc bản vẽ này và tự động tạo các tài nguyên backend. Sau khi backend hoàn tất, ta lấy các thông số API và Cognito trong phần Outputs, cấu hình frontend, rồi host website tĩnh bằng Amazon S3.

#### Các dịch vụ AWS chính

- **Amazon S3**: Lưu trữ file backend đã đóng gói và host frontend website.
- **AWS CloudFormation**: Triển khai backend system từ file `template.yaml`.
- **AWS Lambda**: Chạy serverless backend business logic.
- **Amazon API Gateway**: Cung cấp REST APIs cho frontend.
- **Amazon DynamoDB**: Lưu trữ dữ liệu của ứng dụng.
- **Amazon Cognito**: Cung cấp tài nguyên xác thực người dùng.

#### Nội dung

1. [Tổng quan workshop](5.1-Workshop-overview/)
2. [Chuẩn bị backend code và upload lên S3](5.2-Prerequiste/)
3. [Triển khai backend bằng CloudFormation](5.3-S3-vpc/)
4. [Triển khai frontend bằng Amazon S3](5.4-S3-onprem/)
5. [Kiểm tra kết quả triển khai](5.5-Policy/)
6. [Dọn dẹp tài nguyên](5.6-Cleanup/)