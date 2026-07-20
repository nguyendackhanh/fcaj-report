---
title: "Worklog Tuần 10"
date: 2026-06-22
weight: 10
chapter: false
pre: " <b> 1.10. </b> "
---

### Mục tiêu tuần 10:

* Thiết lập hệ thống giám sát cho ứng dụng bằng Amazon CloudWatch.
* Xây dựng Custom Metrics và Dashboard để theo dõi hoạt động của hệ thống.
* Theo dõi hiệu năng và hỗ trợ phát hiện lỗi trong quá trình vận hành.

### Các công việc cần triển khai trong tuần này:

| Thứ | Công việc | Ngày bắt đầu | Ngày hoàn thành | Nguồn tài liệu |
| --- | --- | --- | --- | --- |
| 2 | - Tìm hiểu Amazon CloudWatch Metrics và Logs.<br>- Nghiên cứu cách tạo Custom Metrics từ AWS Lambda. | 22/06/2026 | 22/06/2026 | https://docs.aws.amazon.com/cloudwatch |
| 3 | - Thêm mã nguồn ghi nhận Custom Metrics trong Lambda.<br>- Theo dõi số lượng người tham gia thi và số lượng API được gọi. | 23/06/2026 | 23/06/2026 | AWS Documentation |
| 4 | - Thiết kế CloudWatch Dashboard.<br>- Hiển thị số lượng người dùng trực tuyến, thời gian phản hồi API và số lượng yêu cầu xử lý. | 24/06/2026 | 24/06/2026 | AWS Documentation |
| 5 | - Thiết lập CloudWatch Alarm cho các chỉ số quan trọng.<br>- Kiểm tra hoạt động của Alarm khi hệ thống phát sinh lỗi hoặc vượt ngưỡng cấu hình. | 25/06/2026 | 25/06/2026 | AWS Documentation |
| 6 | - Đánh giá Dashboard.<br>- Điều chỉnh Metrics và Dashboard theo góp ý của mentor.<br>- Hoàn thiện chức năng giám sát hệ thống. | 26/06/2026 | 26/06/2026 | Tài liệu nội bộ |

### Kết quả đạt được tuần 10:

* Hiểu cách hoạt động của Amazon CloudWatch trong việc giám sát hệ thống.
* Xây dựng thành công các Custom Metrics phục vụ theo dõi ứng dụng.
* Thiết kế Dashboard hiển thị các chỉ số quan trọng như:
  * Số lượng người tham gia thi.
  * Thời gian phản hồi của API.
  * Số lượng yêu cầu được xử lý.
* Thiết lập CloudWatch Alarm để cảnh báo khi hệ thống phát sinh bất thường.
* Hoàn thiện chức năng giám sát giúp hỗ trợ vận hành và theo dõi hệ thống hiệu quả.