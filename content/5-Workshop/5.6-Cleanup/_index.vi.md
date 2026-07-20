---
title : "Dọn dẹp tài nguyên"
date: 2026-06-30
weight : 6
chapter : false
pre : " <b> 5.6. </b> "
---

Chúc mừng bạn đã hoàn thành workshop. Để tránh phát sinh chi phí AWS không cần thiết, hãy dọn dẹp các tài nguyên đã tạo trong quá trình triển khai.

#### 1. Xóa CloudFormation stack

1. Mở AWS CloudFormation.
2. Chọn stack `EventApp-Backend-System`.
3. Chọn **Delete stack**.
4. Xác nhận xóa và chờ đến khi stack được remove hoàn toàn.

CloudFormation sẽ xóa các backend resources mà nó đã tạo, ví dụ Lambda functions, API Gateway, DynamoDB tables, Cognito resources, IAM roles và các cấu hình liên quan.

#### 2. Empty và xóa frontend bucket

1. Mở Amazon S3.
2. Chọn frontend bucket lấy từ CloudFormation Outputs.
3. Empty bucket.
4. Xóa bucket sau khi bucket đã trống.

#### 3. Xóa backend package bucket

Nếu bạn tạo một S3 bucket riêng để chứa backend package, hãy xóa backend package đã upload trước, sau đó xóa bucket.

Ví dụ backend package bucket:

```text
buketbackend
```

#### 4. Xóa build artifacts ở local

Có thể xóa thêm các build artifacts ở local nếu không còn cần dùng:

- Backend `dist` package
- `backend-code.zip` hoặc `backend.rar`
- Frontend `dist` folder

Sau khi cleanup, các tài nguyên của workshop đã được xóa và tài khoản AWS sẽ không còn bị tính phí cho project đã triển khai.