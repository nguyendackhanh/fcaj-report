# Bước 7: Dọn dẹp tài nguyên - "Hoàn trả mặt bằng"

Chào bạn! Để kết thúc bài Lab 20, chúng mình tiến hành xóa bỏ các tài nguyên đã tạo để tránh phát sinh chi phí không mong muốn.

## 1. Kế hoạch dọn dẹp
1. Xóa Transit Gateway Attachments (4 cái).
2. Xóa Transit Gateway Route Table.
3. Xóa Transit Gateway.
4. Xóa CloudFormation Stack Lab20-Stack.
5. Xóa Key Pair 	gw-key.

## 2. Các lệnh đã chạy
`powershell
# Xoa Attachment
aws ec2 delete-transit-gateway-vpc-attachment --transit-gateway-attachment-id <ID>

# Xoa TGW Route Table
aws ec2 delete-transit-gateway-route-table --transit-gateway-route-table-id <RT_ID>

# Xoa Transit Gateway
aws ec2 delete-transit-gateway --transit-gateway-id <TGW_ID>

# Xoa Stack
aws cloudformation delete-stack --stack-name Lab20-Stack

# Xoa Key Pair
aws ec2 delete-key-pair --key-name tgw-key
`

---
## 3. Nhật ký thực thi (Hoàn thành)
- **Attachments**: Đã xóa thành công.
- **TGW Route Table**: Đã xóa thành công.
- **Transit Gateway**: Đã xóa thành công.
- **Lab20-Stack**: Đã biến mất (Deleted).
- **Key Pair**: Đã xóa thành công.

-> **KẾT THÚC TOÀN BỘ LAB 20**.
---

### BẰNG CHỨNG KIỂM TRA CUỐI CÙNG (AWS CLEAN):
- Transit Gateway: **Deleted**
- Stacks & Instances: **None**
- Key Pair: **None**
