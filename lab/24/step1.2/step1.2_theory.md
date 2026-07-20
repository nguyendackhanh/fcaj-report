# Lý thuyết Bước 1.2: Tạo EC2 cho Storage Gateway

## Mục tiêu
Triển khai một máy chủ EC2 sử dụng Amazon Machine Image (AMI) chuyên dụng của Storage Gateway. Máy chủ này sẽ hoạt động như một cầu nối giữa hạ tầng On-premise và AWS S3.

## Cấu hình chi tiết
- **AMI:** Được chọn tự động khi nhấn "Launch instance" từ giao diện Storage Gateway.
- **Instance Type:** `m4.large` (Tối thiểu 2 vCPUs, 16 GiB RAM).
- **Storage:**
    - **Root Volume:** Mặc định cho hệ điều hành.
    - **Cache Volume:** Cần thêm tối nhất 150 GiB (EBS) để làm vùng nhớ đệm (Cache), giúp tăng tốc độ truy cập file.
- **Network:** Cần Public IP để có thể kích hoạt Gateway từ xa.
- **Security Group:** `storagegw-instance-sg`. Cần mở các cổng:
    - **TCP 80/443:** Kích hoạt và quản lý.
    - **TCP/UDP 111, 2049, 20048:** Dành cho giao thức NFS.
    - **TCP/UDP 445, 139:** Dành cho giao thức SMB.

## Thao tác trên Console
1. Tại Storage Gateway Console, chọn **Create gateway** -> **Amazon EC2**.
2. Nhấn **Launch instance** để mở tab EC2 với AMI đúng.
3. Chọn type `m4.large`.
4. Tạo Key Pair `storagegw-key`.
5. Cấu hình Security Group với các port trên.
6. Thêm Volume 150GB.
7. Launch và copy **Public IP**.
