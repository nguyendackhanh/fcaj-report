---
title: "Worklog Tuần 4"
date: 2026-05-11
weight: 4
chapter: false
pre: " <b> 1.4. </b> "
---

### Mục tiêu tuần 4:

- Tìm hiểu giao tiếp thời gian thực (Real-time Communication) trên AWS.
- Làm quen với Amazon API Gateway WebSocket và AWS Lambda.
- Thực hành xây dựng WebSocket API cơ bản.

### Các công việc cần triển khai trong tuần này:

| Thứ | Công việc                                                                                                                             | Ngày bắt đầu | Ngày hoàn thành | Nguồn tài liệu                         |
| --- | ------------------------------------------------------------------------------------------------------------------------------------- | ------------ | --------------- | -------------------------------------- |
| 2   | - Tìm hiểu sự khác nhau giữa REST API và WebSocket API.<br>- Tìm hiểu các trường hợp sử dụng WebSocket trong hệ thống thời gian thực. | 11/05/2026   | 11/05/2026      | https://docs.aws.amazon.com/apigateway |
| 3   | - Tạo WebSocket API Gateway.<br>- Cấu hình các Route ($connect, $disconnect, sendMessage).                                            | 12/05/2026   | 12/05/2026      | AWS Documentation                      |
| 4   | - Kết nối WebSocket API với AWS Lambda.<br>- Xử lý sự kiện kết nối và ngăt kết nối.                                                   | 13/05/2026   | 13/05/2026      | https://docs.aws.amazon.com/lambda     |
| 5   | - Thực hành gửi và nhận dữ liệu qua WebSocket.<br>- Lưu ConnectionId để quản lý kết nối người dùng.                                   | 14/05/2026   | 14/05/2026      | AWS Documentation                      |
| 6   | - Kiểm tra log bằng CloudWatch.<br>- Xử lý lỗi trong quá trình gửi và nhận dữ liệu.                                                   | 15/05/2026   | 15/05/2026      | https://docs.aws.amazon.com/cloudwatch |

### Kết quả đạt được tuần 4:

- Hiểu được nguyên lý hoạt động của WebSocket API trên AWS.

- Tạo thành công WebSocket API Gateway.

- Kết nối WebSocket với AWS Lambda.

- Biết cách lưu và quản lý ConnectionId.

- Có thể gửi và nhận dữ liệu theo thời gian thực.

- Sử dụng CloudWatch để theo dõi và xử lý lỗi.
