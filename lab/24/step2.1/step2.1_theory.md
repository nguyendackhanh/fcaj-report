# Lý thuyết Bước 2.1: Tạo Storage Gateway

## Mục tiêu
Kết nối máy chủ EC2 (đã cài Gateway software) với dịch vụ AWS Storage Gateway để bắt đầu quản lý.

## Các khái niệm chính
- **Activation Key:** Một chuỗi khóa dùng để xác thực và gán Gateway vào tài khoản AWS của bạn. Khóa này được lấy tự động bằng cách trình duyệt web truy cập vào Public IP của Gateway (qua cổng 80).
- **Cache Storage:** Vùng lưu trữ đệm. Chúng ta sẽ sử dụng Volume 150GB đã gắn ở bước 1.2 để làm vùng này. Nó giúp lưu các file thường xuyên truy cập tại chỗ để giảm độ trễ.
- **Gateway Type:** File Gateway (S3).

## Thao tác trên Console
1. Tại giao diện Storage Gateway, chọn **Create gateway**.
2. Nhập tên: `filesgw`.
3. Nhập **Public IP** của máy EC2.
4. Nhấn **Activate gateway**.
5. Cấu hình **Configure cache storage**: Chọn Volume 150GB.
6. (Tùy chọn) Vào **Edit SMB settings** -> **Guest access** -> Đặt mật khẩu cho Guest nếu dùng SMB.
