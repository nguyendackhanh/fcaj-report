# Bước 5: VPC Peering & Route Table - "Xây cầu và Mở đường"

Chào bạn! Đây là bước "vỡ òa" nhất của bài Lab. Chúng mình sẽ chính thức kết nối hai mạng VPC lại với nhau và chứng minh rằng chúng có thể nói chuyện nội bộ mà không cần đi qua Internet.

## 1. Kế hoạch thực hiện
- **Việc 1: Xây cầu (Peering)**: Tạo một kết nối Peering giữa My VPC (Requester) và HG VPC (Accepter). Sau đó chấp nhận kết nối này.
- **Việc 2: Khai thông lộ trình (Route Table)**: Cập nhật bảng định tuyến của cả 2 VPC để chúng biết đường đi qua cầu.
- **Việc 3: Kiểm chứng (The Moment of Truth)**: SSH vào máy My VPC và Ping sang máy HG VPC bằng **Private IP**.

## 2. Các lệnh dự kiến sẽ chạy
1. ws ec2 create-vpc-peering-connection: Gửi yêu cầu kết nối.
2. ws ec2 accept-vpc-peering-connection: Chấp nhận kết nối.
3. ws ec2 create-route: Thêm đường đi vào bảng định tuyến của My VPC.
4. ws ec2 create-route: Thêm đường đi vào bảng định tuyến của HG VPC.
5. Lệnh Ping để kiểm tra kết quả.

---
## 3. Nhật ký thực thi (Đã hoàn thành rực rỡ!)

### Lệnh tạo và chấp nhận Peering:
`powershell
# Tao yeu cau
aws ec2 create-vpc-peering-connection --vpc-id vpc-0942fb7e7e76076c4 --peer-vpc-id vpc-0f05a1afa7948566d ...
# Chap nhan
aws ec2 accept-vpc-peering-connection --vpc-peering-connection-id pcx-090d74e86be2191f7
`

### Lệnh cập nhật Route Table:
`powershell
# Cho My VPC
aws ec2 create-route --route-table-id rtb-00bcfeff7dfca4dc3 --destination-cidr-block 10.10.0.0/16 --vpc-peering-connection-id pcx-090d74e86be2191f7
# Cho HG VPC
aws ec2 create-route --route-table-id rtb-01fa8afdbacccd193 --destination-cidr-block 172.31.0.0/16 --vpc-peering-connection-id pcx-090d74e86be2191f7
`

### [LOG THỰC TẾ] Khoảnh khắc vỡ òa - Ping Private IP thành công:
`	ext
PING 10.10.2.213 (10.10.2.213) 56(84) bytes of data.
64 bytes from 10.10.2.213: icmp_seq=1 ttl=255 time=0.656 ms
64 bytes from 10.10.2.213: icmp_seq=2 ttl=255 time=0.475 ms
64 bytes from 10.10.2.213: icmp_seq=3 ttl=255 time=0.434 ms

--- 10.10.2.213 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2025ms
`
-> **Kết luận**: Chiếc cầu đã thông! Hai máy chủ hiện đã có thể giao tiếp với nhau bằng mạng nội bộ bảo mật, không cần đi qua Internet công cộng.
---


