---
title: "Video Demo"
date: 2026-06-28
weight: 8
chapter: false
pre: " <b> 8. </b> "
---

# 📋 Danh Sách Chức Năng Hệ Thống

Tài liệu tóm tắt các chức năng chính của người dùng (User) và quản trị viên (Admin) trên hệ thống AWS Serverless Event Management Portal.

<iframe src="https://drive.google.com/file/d/1Y3MPZf0hw9Wffg0gG8jd0tQ1gRZOB3bQ/preview" width="100%" height="450" allow="autoplay"></iframe>

## 👥 1. Chức Năng Của Người Dùng (User / Visitor)

*   **Xem & tìm kiếm sự kiện:** Duyệt danh sách các sự kiện đang có, tìm kiếm bằng từ khóa hoặc lọc nhanh theo chuyên mục (Technology, Music, Sports...).
*   **Xem chi tiết sự kiện:** Xem thông tin mô tả, địa điểm, thời gian, số lượng ghế trống, các đánh giá trước đó và các sự kiện gợi ý liên quan.
*   **Đăng ký & Đăng nhập:** Tạo tài khoản mới hoặc đăng nhập hệ thống bảo mật thông qua Cognito.
*   **Đăng ký đặt vé:** Đặt vé tham gia sự kiện còn chỗ trống, nhận mã vé điện tử và mã QR để điểm danh.
*   **Tham gia danh sách chờ (Waitlist):** Điền thông tin đăng ký vào hàng đợi khi sự kiện đã hết ghế.
*   **Quản lý hồ sơ cá nhân:** Xem lịch sử các sự kiện đã đặt vé, đổi mật khẩu và tùy chọn xóa tài khoản.
*   **Đánh giá sự kiện:** Chấm điểm sao và gửi nhận xét cho các sự kiện đã tham gia thực tế (đã check-in).
*   **Xuất lịch cá nhân:** Tải file lịch `.ics` hoặc thêm sự kiện trực tiếp vào Google Calendar.

---

## 👑 2. Chức Năng Của Quản Trị Viên (Admin)

*   **Quản lý sự kiện (CRUD):** Thêm mới sự kiện, cập nhật thông tin chi tiết hoặc xóa sự kiện khỏi hệ thống.
*   **Quản lý danh sách thành viên:** Xem danh sách chi tiết những người đã đăng ký tham gia của từng sự kiện (Email, Mã vé, Ngày đặt, Trạng thái vé).
*   **Điểm danh bằng mã QR (Check-in):** Quét mã QR trên vé của khách tham gia (hoặc nhập mã vé thủ công) để xác nhận điểm danh và chống sử dụng vé trùng lặp.
*   **Kiểm soát truy cập:** Quản lý giao diện Dashboard riêng cho Admin và tự động ngăn chặn các tài khoản thông thường truy cập.
