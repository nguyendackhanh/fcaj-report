# Bước 2.3: Copy chìa khóa lên máy chủ trung chuyển (Jump Host)

Chào bạn! Để có thể di chuyển linh hoạt giữa các VPC, chúng mình cần đưa chìa khóa 	gw-key.pem lên hai máy chủ có IP công cộng là First Host và Third Host.

## 1. Kế hoạch thực hiện
- **Máy đích 1**: First Host (54.255.166.130)
- **Máy đích 2**: Third Host (13.229.236.182)
- **Hành động**: Dùng lệnh scp để đẩy file chìa khóa lên thư mục home của máy chủ.

## 2. Các lệnh dự kiến sẽ chạy
`powershell
scp -i tgw-key.pem tgw-key.pem ec2-user@54.255.166.130:/home/ec2-user/
scp -i tgw-key.pem tgw-key.pem ec2-user@13.229.236.182:/home/ec2-user/
`

---
## 3. Nhật ký thực thi (Hoàn thành)

### Lệnh đã chạy:
`powershell
scp -i tgw-key.pem -o StrictHostKeyChecking=no tgw-key.pem ec2-user@54.255.166.130:/home/ec2-user/
scp -i tgw-key.pem -o StrictHostKeyChecking=no tgw-key.pem ec2-user@13.229.236.182:/home/ec2-user/
`

### Phản hồi từ PowerShell:
`	ext
Warning: Permanently added '54.255.166.130' to the list of known hosts.
Warning: Permanently added '13.229.236.182' to the list of known hosts.
`
-> **Kết luận**: Hai máy chủ trung chuyển đã có chìa khóa. Bây giờ chúng mình đã sẵn sàng để cấu hình "Nhà ga trung tâm" Transit Gateway rồi!
---

