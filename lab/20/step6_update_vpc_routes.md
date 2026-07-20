# Bước 6: Cập nhật Route Table của VPC - "Thông mạng toàn hệ thống"

Chào bạn! Đây là những viên gạch cuối cùng. Chúng mình sẽ báo cho từng VPC biết rằng: "Nếu muốn gửi dữ liệu sang các VPC khác, hãy gửi nó qua Transit Gateway".

## 1. Kế hoạch thực hiện
- **VPC1 & VPC3**: Thêm route 172.16.0.0/16 -> TGW.
- **VPC2 & VPC4**: Thêm route 0.0.0.0/0 -> TGW.

## 2. Các lệnh dự kiến sẽ chạy
```powershell
aws ec2 create-route --route-table-id <RT_ID> --destination-cidr-block <CIDR> --transit-gateway-id tgw-058ef8d76a862176e
```

---
## 3. Nhật ký thực thi (Hoàn thành)

### Kết quả Ping (VPC1 -> VPC2 & VPC4):
- **VPC1 -> VPC2**: 0% packet loss (Thành công!)
- **VPC1 -> VPC4**: 0% packet loss (Thành công!)

### Phản hồi từ PowerShell:
- **Trạng thái**: Tất cả các lệnh create-route đều trả về { "Return": true }.

### CHI TIẾT LOG KẾT QUẢ (TERMINAL OUTPUT):
```text
Ping VPC2 (172.16.2.9) tu VPC1:
64 bytes from 172.16.2.9: icmp_seq=1 ttl=254 time=1.72 ms
64 bytes from 172.16.2.9: icmp_seq=2 ttl=254 time=0.501 ms
64 bytes from 172.16.2.9: icmp_seq=3 ttl=254 time=0.538 ms
64 bytes from 172.16.2.9: icmp_seq=4 ttl=254 time=0.520 ms
64 bytes from 172.16.2.9: icmp_seq=5 ttl=254 time=0.542 ms
--- 172.16.2.9 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4068ms

Ping VPC4 (172.16.4.13) tu VPC1:
64 bytes from 172.16.4.13: icmp_seq=1 ttl=254 time=1.46 ms
64 bytes from 172.16.4.13: icmp_seq=2 ttl=254 time=0.277 ms
64 bytes from 172.16.4.13: icmp_seq=3 ttl=254 time=0.275 ms
64 bytes from 172.16.4.13: icmp_seq=4 ttl=254 time=0.269 ms
64 bytes from 172.16.4.13: icmp_seq=5 ttl=254 time=0.298 ms
--- 172.16.4.13 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4050ms
```

-> **KẾT LUẬN CUỐI CÙNG**: Lab 20 đã hoàn tất. Transit Gateway đã kết nối thành công 4 VPC với nhau. Chúc mừng bạn!
---
