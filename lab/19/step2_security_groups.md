# Bước 2: Lắp cổng và khóa bảo mật - "An ninh cho tòa nhà"

Chào bạn! Sau khi đã có khung nhà ở Bước 1, chúng mình không thể để cửa mở toang hoác được. Bước này chúng mình sẽ thiết lập **Security Group (SG)** - đóng vai trò như những người bảo vệ đứng ở cổng mỗi VPC.

## 1. Tìm IP nhà bạn
Để đảm bảo chỉ mình bạn có quyền vào "quậy phá" các máy chủ này, mình đã dùng lệnh để hỏi AWS xem IP hiện tại của bạn là gì:
`powershell
curl.exe -s https://checkip.amazonaws.com
`
*Kết quả:* IP của bạn là 116.98.254.56. Chúng mình sẽ dùng cái này làm "thẻ bài" để SSH.

## 2. Tạo Security Group (Xây bốt bảo vệ)
Chúng mình tạo 2 SG riêng biệt cho 2 VPC đã có.

**Lệnh tạo cho My VPC:**
`powershell
aws ec2 create-security-group `
  --group-name "MY VPC SG" `
  --description "Security Group for My VPC" `
  --vpc-id vpc-0942fb7e7e76076c4
`
-> ID nhận được: `sg-07eb74cd3cacb390b`

**Lệnh tạo cho HG VPC:**
`powershell
aws ec2 create-security-group `
  --group-name "HG VPC SG" `
  --description "Security Group for HG VPC" `
  --vpc-id vpc-0f05a1afa7948566d
`
-> ID nhận được: `sg-08be10f488891cd7c`

## 3. Cấu hình luật lệ (Inbound Rules)
Đây là phần quan trọng nhất. Chúng mình đã mở các "cửa" sau:

### Cho My VPC (Khu A):
1. **Cổng SSH (22)**: Chỉ cho IP 116.98.254.56 của bạn.
2. **Cổng Ping (ICMP)**: Mở cho toàn thế giới để test mạng Internet.
3. **Cổng Ping nội bộ**: Mở cho dải IP của HG VPC (10.10.0.0/16).

**Lệnh thực hiện:**
`powershell
aws ec2 authorize-security-group-ingress --group-id sg-07eb74cd3cacb390b --protocol tcp --port 22 --cidr 116.98.254.56/32
aws ec2 authorize-security-group-ingress --group-id sg-07eb74cd3cacb390b --protocol icmp --port -1 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id sg-07eb74cd3cacb390b --protocol icmp --port -1 --cidr 10.10.0.0/16
`

### Cho HG VPC (Khu B):
Tương tự, nhưng cổng Ping nội bộ sẽ mở cho dải IP của My VPC (172.31.0.0/16).

**Lệnh thực hiện:**
`powershell
aws ec2 authorize-security-group-ingress --group-id sg-08be10f488891cd7c --protocol tcp --port 22 --cidr 116.98.254.56/32
aws ec2 authorize-security-group-ingress --group-id sg-08be10f488891cd7c --protocol icmp --port -1 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id sg-08be10f488891cd7c --protocol icmp --port -1 --cidr 172.31.0.0/16
`

---
*Ghi chú: Giờ thì an ninh đã siết chặt, chúng mình sẵn sàng đón "cư dân" (máy chủ EC2) vào ở rồi!*

