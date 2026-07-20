# Bước 1: Tạo Key Pair - "Chìa khóa cho Transit Gateway"

Chào bạn! Chúng mình bắt đầu hành trình Lab 20 với bước đầu tiên là tạo chìa khóa số (Key Pair) để lát nữa có thể truy cập vào các máy chủ EC2.

## 1. Kế hoạch thực hiện
- **Tên chìa khóa**: 	tgw-key
- **Định dạng**: .pem
- **Hành động**: Dùng AWS CLI để tạo Key Pair và lưu nội dung vào file cục bộ.

## 2. Các lệnh dự kiến sẽ chạy
`powershell
aws ec2 create-key-pair --key-name tgw-key --query 'KeyMaterial' --output text
`

---
## 3. Nhật ký thực thi (Hoàn thành)

### Lệnh đã chạy:
`powershell
aws ec2 create-key-pair --key-name tgw-key --query 'KeyMaterial' --output text | Out-File -Encoding ascii -FilePath "lab/20/tgw-key.pem"
`

### Phản hồi từ PowerShell:
`	ext
True
Lệnh tạo Key Pair đã hoàn tất. File tgw-key.pem đã được lưu vào thư mục lab/20.
`
-> **Kết luận**: Bước khởi đầu đã xong xuôi. Chúng mình đã có chìa khóa để đi tiếp vào khu rừng Transit Gateway!
---

