# Bước 6: Kích hoạt Cross-Peer DNS - "Gọi tên nhau qua cầu"

Chào bạn! Đây là bước tinh chỉnh cuối cùng để hệ thống của chúng mình hoạt động hoàn hảo. 

## 1. Kế hoạch thực hiện
- **Mục tiêu**: Cho phép máy chủ ở VPC này có thể phân giải tên miền (DNS) của máy chủ ở VPC kia ra địa chỉ IP nội bộ (Private IP). 
- **Tại sao cần thiết?**: Nếu không có bước này, khi bạn gọi tên DNS của máy HG VPC, nó sẽ trả về IP Public. Mà IP Public thì đã bị chúng mình chặn ở Bước 4 (NACL) rồi, nên kết nối sẽ thất bại.
- **Hành động**: Chạy lệnh cập nhật thuộc tính DNS cho Peering Connection.

## 2. Các lệnh dự kiến sẽ chạy
1. ws ec2 modify-vpc-peering-connection-options: Bật tính năng DNS resolution cho cả phía Requester và Accepter.
2. ws ec2 describe-instances: Lấy tên Public DNS của máy HG VPC để test.
3. Lệnh Ping DNS name để kiểm tra xem nó trỏ về IP nào.

---
## 3. Nhật ký thực thi (Hoàn tất bài Lab!)

### Lệnh cập nhật thuộc tính DNS:
`powershell
aws ec2 modify-vpc-peering-connection-options `
  --vpc-peering-connection-id pcx-090d74e86be2191f7 `
  --requester-peering-connection-options AllowDnsResolutionFromRemoteVpc=true `
  --accepter-peering-connection-options AllowDnsResolutionFromRemoteVpc=true
`

### [LOG THỰC TẾ] Phân giải DNS nội bộ thành công:
`	ext
PING ec2-52-221-197-42.ap-southeast-1.compute.amazonaws.com (10.10.2.213) 56(84) bytes of data.
64 bytes from ip-10-10-2-213.ap-southeast-1.compute.internal (10.10.2.213): icmp_seq=1 ttl=255 time=0.372 ms
...
--- ec2-52-221-197-42.ap-southeast-1.compute.amazonaws.com ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2017ms
`
-> **Kết luận**: Hệ thống đã nhận diện được nhau qua tên miền DNS và tự động điều hướng traffic vào mạng nội bộ. Bài Lab kết thúc thành công mỹ mãn!
---


