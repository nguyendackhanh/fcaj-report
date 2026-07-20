# Lý thuyết Bước 2.2: Tạo File Shares

## Mục tiêu
Thiết lập một điểm truy cập (File Share) để máy khách (Client) có thể nhìn thấy S3 Bucket như một thư mục mạng thông thường.

## Chi tiết cấu hình
- **File share type:**
    - **SMB (Server Message Block):** Phổ biến cho Windows.
    - **NFS (Network File System):** Phổ biến cho Linux.
    - *Workshop chọn SMB để thực hiện trên Windows.*
- **Amazon S3 bucket name:** `s3-instancestoragegw-2023` (Bucket đã tạo ở bước 1.1).
- **Authentication:** `Guest access` (Cho phép truy cập bằng mật khẩu Guest đã đặt ở bước 2.1).

## Thao tác trên Console
1. Chọn menu **File shares** -> **Create file share**.
2. Chọn gateway: `filesgw`.
3. Chọn type: `SMB`.
4. Nhập tên S3 bucket.
5. Chọn **Guest access**.
6. Nhấn **Create file share**.
7. Sau khi tạo xong, trạng thái phải là **Available**. Copy lệnh Mount ở phía dưới trang thông tin.
