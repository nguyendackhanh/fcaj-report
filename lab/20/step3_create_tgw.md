# Bước 3: Tạo Transit Gateway - "Xây nhà ga trung tâm"

Chào bạn! Đây là linh hồn của bài Lab 20. Chúng mình sẽ tạo ra một Hub trung tâm (Transit Gateway) để điều phối traffic giữa các VPC.

## 1. Kế hoạch thực hiện
- **Tên**: lab20-tgw
- **Mô tả**: Transit Gateway for lab20
- **Cấu hình đặc biệt**: Vô hiệu hóa Association và Propagation mặc định để chúng mình tự tay cấu hình ở các bước sau (giúp hiểu sâu hơn).

## 2. Các lệnh dự kiến sẽ chạy
`powershell
aws ec2 create-transit-gateway `
  --description "Transit Gateway for lab20" `
  --options DefaultRouteTableAssociation=disable,DefaultRouteTablePropagation=disable `
  --tag-specifications "ResourceType=transit-gateway,Tags=[{Key=Name,Value=lab20-tgw}]"
`

---
## 3. Nhật ký thực thi (Hoàn thành)

### Lệnh đã chạy:
`powershell
aws ec2 create-transit-gateway `
  --description "Transit Gateway for lab20" `
  --options DefaultRouteTableAssociation=disable,DefaultRouteTablePropagation=disable `
  --tag-specifications "ResourceType=transit-gateway,Tags=[{Key=Name,Value=lab20-tgw}]"
`

### Phản hồi từ PowerShell:
`json
{
    "TransitGateway": {
        "TransitGatewayId": "tgw-058ef8d76a862176e",
        "State": "pending",
        ...
    }
}
`
-> **Kết luận**: Nhà ga trung tâm lab20-tgw đã được xây dựng xong. Bước tiếp theo chúng mình sẽ "nối dây" các VPC vào nhà ga này.
---

