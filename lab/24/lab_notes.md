# Nhật ký Lab: Triển khai AWS Storage Gateway

## Tổng quan
Workshop này hướng dẫn cách triển khai File Storage Gateway để thiết lập một File Sharing kết nối với các máy ở On-premise.

## Danh sách các bước
- [x] 1. Chuẩn bị
    - [x] 1.1 Tạo S3 Bucket
    - [x] 1.2 Tạo EC2 cho Storage Gateway
- [ ] 2. Sử dụng AWS Storage Gateway
    - [x] 2.1 Tạo Storage Gateway
    - [x] 2.2 Tạo File Shares
    - [x] 2.3 Kết nối File shares ở máy On-premise nhe
- [ ] 3. Dọn dẹp tài nguyên

---
## Ghi chú chi tiết

### 1. Chuẩn bị
#### 1.1 Tạo S3 Bucket
- **Mục tiêu:** Tạo một S3 Bucket làm nơi lưu trữ dữ liệu cho File Gateway.
- **Region:** `ap-southeast-1` (Singapore).
- **Tên Bucket gợi ý:** `s3-instancestoragegw-2023` (Cần duy nhất trên toàn cầu).
- **Lệnh AWS CLI:**
  ```bash
  aws s3 mb s3://s3-instancestoragegw-<your-unique-suffix> --region ap-southeast-1
  ```

#### 1.2 Tạo EC2 cho Storage Gateway
- **Mục tiêu:** Chạy một Instance EC2 cài đặt sẵn phần mềm Storage Gateway.
- **Cấu hình:**
    - Instance type: `m4.large`.
    - Key pair: `storagegw-key`.
    - Security Group: `storagegw-instance-sg`.
    - Storage: Thêm volume 150GB (Cache).
- **Inbound Rules:** Port 111, 2049, 20048 (NFS) và 80, 443 (Activation).
- **Lưu ý:** Sau khi launch, cần lấy **Public IP** của instance này.

### 2. Sử dụng AWS Storage Gateway
#### 2.1 Tạo Storage Gateway
- **Mục tiêu:** Kích hoạt gateway và kết nối nó với AWS.
- **Thao tác chính:**
    - Kết nối bằng Public IP của EC2.
    - Đặt tên: `filesgw`.
    - Gán Volume 150GB làm **Cache storage**.
    - Tắt CloudWatch logging và Alarms để tiết kiệm chi phí/thời gian.
- **SMB Settings:** Cấu hình mật khẩu `Guest access` nếu sử dụng SMB.

#### 2.2 Tạo File Shares
- **Mục tiêu:** Tạo một chia sẻ tệp tin ánh xạ tới S3 bucket.
- **Thao tác chính:**
    - Chọn gateway: `filesgw`.
    - Loại share: `SMB`.
    - Kết nối tới S3 Bucket: `s3-instancestoragegw-2023`.
    - Authentication: `Guest access` (Sử dụng mật khẩu đã tạo).
- **Kết quả:** Sau khi tạo, cần copy lệnh **Mount command** để sử dụng ở máy khách.

#### 2.3 Kết nối File shares ở máy On-premise
- **Mục tiêu:** Ánh xạ File Share thành ổ đĩa mạng trên máy local.
- **Câu lệnh Mount (Windows CMD):**
  ```cmd
  net use Z: \\<Public_IP_EC2>\<S3_Bucket_Name> /user:<Gateway_ID>\smbguest
  ```
- **Xác nhận:** Sau khi nhập mật khẩu Guest, ổ đĩa `Z:` sẽ xuất hiện. Thử copy file vào và kiểm tra trên S3 Console.

### 3. Dọn dẹp tài nguyên
*Đang cập nhật...*
