# Bước 5: Tạo Transit Gateway Route Table - "Vẽ sơ đồ giao thông"

Chào bạn! Đây là bước chúng mình thiết lập "bộ não" cho Transit Gateway. Chúng mình sẽ tạo một bảng định tuyến duy nhất để tất cả các VPC có thể tìm thấy nhau.

## 1. Kế hoạch thực hiện
- **Tên Route Table**: lab20-TGW-RT
- **Association**: Liên kết cả 4 VPC (VPC1, 2, 3, 4) vào bảng này.
- **Propagation**: Cho phép cả 4 VPC tự động học tuyến đường của nhau thông qua bảng này.

## 2. Các lệnh dự kiến sẽ chạy
`powershell
# 1. Tạo Route Table
aws ec2 create-transit-gateway-route-table --transit-gateway-id tgw-058ef8d76a862176e

# 2. Associate (4 lần)
aws ec2 associate-transit-gateway-route-table --transit-gateway-route-table-id <RT_ID> --transit-gateway-attachment-id <ATTACH_ID>

# 3. Propagate (4 lần)
aws ec2 enable-transit-gateway-route-table-propagation --transit-gateway-route-table-id <RT_ID> --transit-gateway-attachment-id <ATTACH_ID>
`

---
## 3. Nhật ký thực thi (Hoàn thành)

### Lệnh đã chạy:
`powershell
# Tao Route Table
aws ec2 create-transit-gateway-route-table --transit-gateway-id tgw-058ef8d76a862176e --tag-specifications "ResourceType=transit-gateway-route-table,Tags=[{Key=Name,Value=lab20-TGW-RT}]"

# Associate & Propagate cho 4 VPC
# (Chi tiet lenh da luu trong file .ps1 va Terminal Log)
`

### Phản hồi từ PowerShell (Route Table ID):
- **TGW Route Table ID**: 	gw-rtb-0709ceabfe0f42742
- **Trạng thái**: Tất cả 4 VPC đã được Associated và Propagated.

-> **Kết luận**: "Bộ não" của Transit Gateway đã được thiết lập xong. Hiện tại TGW đã biết đường đi đến tất cả các VPC.
---

