---
title: "Worklog Tuần 9"
date: 2026-06-15
weight: 9
chapter: false
pre: " <b> 1.9. </b> "
---

### Mục tiêu tuần 9:

* Thiết lập hệ thống gửi thông báo bằng Amazon SNS.
* Tích hợp Amazon SQS để xử lý nộp bài thi hàng loạt.
* Tối ưu luồng xử lý bất đồng bộ của hệ thống.

### Các công việc cần triển khai trong tuần này:

| Thứ | Công việc | Ngày bắt đầu | Ngày hoàn thành | Nguồn tài liệu |
| --- | --- | --- | --- | --- |
| 2 | - Tìm hiểu cơ chế hoạt động của Amazon SNS.<br>- Thiết lập SNS Topic phục vụ gửi thông báo. | 15/06/2026 | 15/06/2026 | https://docs.aws.amazon.com/sns |
| 3 | - Tạo Subscription và kiểm tra gửi thông báo.<br>- Kiểm thử Publish Message từ Lambda. | 16/06/2026 | 16/06/2026 | AWS Documentation |
| 4 | - Tích hợp Amazon SQS để tiếp nhận yêu cầu nộp bài thi hàng loạt. | 17/06/2026 | 17/06/2026 | https://docs.aws.amazon.com/sqs |
| 5 | - Xây dựng Lambda Worker đọc Message từ SQS.<br>- Kiểm tra cơ chế Retry và Dead Letter Queue. | 18/06/2026 | 18/06/2026 | AWS Documentation |
| 6 | - Kiểm thử toàn bộ luồng xử lý bất đồng bộ.<br>- Đánh giá hiệu năng và chỉnh sửa các lỗi phát sinh. | 19/06/2026 | 19/06/2026 | Tài liệu nội bộ |

### Kết quả đạt được tuần 9:

* Thiết lập thành công Amazon SNS Topic.
* Gửi và nhận thông báo thông qua SNS.
* Tích hợp Amazon SQS vào hệ thống để xử lý các tác vụ bất đồng bộ.
* Xây dựng Lambda Worker xử lý Message từ Queue.
* Hiểu được cơ chế Retry và Dead Letter Queue.
* Tăng khả năng xử lý đồng thời khi nhiều người dùng nộp bài thi.