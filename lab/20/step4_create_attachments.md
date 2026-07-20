# Bước 4: Tạo Transit Gateway Attachments - "Nối dây vào Nhà ga"

Chào bạn! Bây giờ chúng mình sẽ thực hiện công việc "đấu nối". Từng VPC sẽ được gắn một sợi dây (Attachment) để kết nối trực tiếp vào Transit Gateway.

## 1. Kế hoạch thực hiện
Chúng mình sẽ tạo 4 Attachments cho 4 VPC:
- **VPC1 (First VPC)**: Nối vào TGW.
- **VPC2 (Second VPC)**: Nối vào TGW.
- **VPC3 (Third VPC)**: Nối vào TGW.
- **VPC4 (Fourth VPC)**: Nối vào TGW.

## 2. Các lệnh dự kiến sẽ chạy
`powershell
# Ví dụ cho VPC1
aws ec2 create-transit-gateway-vpc-attachment `
  --transit-gateway-id tgw-058ef8d76a862176e `
  --vpc-id vpc-051a3ec06c1e7e888 `
  --subnet-ids subnet-0e81ba27bc218c906 `
  --tag-specifications "ResourceType=transit-gateway-attachment,Tags=[{Key=Name,Value=VPC1-Attachment}]"
`

---
## 3. Nhật ký thực thi (Hoàn thành)

### Các lệnh đã chạy:
`powershell
# Tao Attachment cho VPC1, VPC2, VPC3, VPC4
aws ec2 create-transit-gateway-vpc-attachment --transit-gateway-id tgw-058ef8d76a862176e --vpc-id vpc-051a3ec06c1e7e888 ...
aws ec2 create-transit-gateway-vpc-attachment --transit-gateway-id tgw-058ef8d76a862176e --vpc-id vpc-0a9f3a4347d4a6e2a ...
aws ec2 create-transit-gateway-vpc-attachment --transit-gateway-id tgw-058ef8d76a862176e --vpc-id vpc-0b8a3f99338d710be ...
aws ec2 create-transit-gateway-vpc-attachment --transit-gateway-id tgw-058ef8d76a862176e --vpc-id vpc-02c8d8295d722676d ...
`

### Phản hồi từ PowerShell (Danh sách ID Attachment):
- **VPC1-Attachment**: 	gw-attach-0fe13b6f145a1c81e
- **VPC2-Attachment**: 	gw-attach-0330053f3c9b202d7
- **VPC3-Attachment**: 	gw-attach-0fdae308e1e1d7a44
- **VPC4-Attachment**: 	gw-attach-0f29921a698e6059c

-> **Kết luận**: Tất cả 4 VPC đã được nối thành công vào Transit Gateway. Hiện tại chúng đang ở trạng thái available (Sẵn sàng).
---

