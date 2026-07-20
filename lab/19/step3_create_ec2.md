# Bước 3: Tạo máy chủ EC2 - "Đưa cư dân vào ở"

Chào bạn! Nhà đã xong, cổng đã khóa, giờ là lúc chúng mình đưa 2 "em" máy chủ (EC2 Instance) vào ở trong 2 khu chung cư này để chuẩn bị test bài Lab VPC Peering.

## 1. Chuẩn bị chìa khóa (Key Pair)
Để có thể đăng nhập vào máy chủ sau này, chúng mình cần một chiếc chìa khóa số. Mình đã tạo nó và lưu vào file .pem.
`powershell
aws ec2 create-key-pair --key-name vpcpeering-key --query 'KeyMaterial' --output text | Out-File -Encoding ascii -FilePath vpcpeering-key.pem
`
*Lưu ý:* File pcpeering-key.pem đang nằm ngay trong thư mục này đấy, bạn đừng làm mất nhé!

## 2. Tìm hệ điều hành (AMI)
Chúng mình chọn **Amazon Linux 2**, một hệ điều hành rất nhẹ và ổn định. Mình đã dùng lệnh này để luôn lấy được bản cập nhật mới nhất từ AWS:
`powershell
aws ec2 describe-images --owners amazon --filters "Name=name,Values=amzn2-ami-hvm-2.0.*-x86_64-gp2" --query "sort_by(Images, &CreationDate)[-1].ImageId" --output text
`
-> Kết quả: ID hệ điều hành là `ami-062cf2a54d864b4ca`.

## 3. "Phóng" máy chủ lên mây
Chúng mình tạo 2 máy chủ 	2.micro (loại máy miễn phí/rẻ nhất) đặt vào Subnet Public của mỗi VPC.

### Máy 1: EC2 - My VPC
`powershell
aws ec2 run-instances `
  --image-id ami-062cf2a54d864b4ca `
  --count 1 --instance-type t2.micro `
  --key-name vpcpeering-key `
  --security-group-ids sg-07eb74cd3cacb390b `
  --subnet-id subnet-00a2b6c610e5128bc `
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value="EC2 - My VPC"}]'
`

### Máy 2: EC2 - HG VPC
`powershell
aws ec2 run-instances `
  --image-id ami-062cf2a54d864b4ca `
  --count 1 --instance-type t2.micro `
  --key-name vpcpeering-key `
  --security-group-ids sg-08be10f488891cd7c `
  --subnet-id subnet-01efac04064362b5e `
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value="EC2 - HG VPC"}]'
`

## 4. Kết quả thu được (Địa chỉ nhà cư dân)
Sau khi đợi máy chủ ở trạng thái unning, đây là thông số chúng mình thu thập được:

| Tên máy chủ | Public IP (Địa chỉ công cộng) | Private IP (Địa chỉ nội bộ) |
| :--- | :--- | :--- |
| **EC2 - My VPC** | `54.179.179.109` | `172.31.2.180` |
| **EC2 - HG VPC** | `52.221.197.42` | `10.10.2.213` |

## 5. Bài test đầu tiên (Trước khi có Peering)
Chúng mình đã thử nghiệm và thấy rằng:
- **Ping Public IP**: Chạy tốt (vì đi vòng qua Internet).
- **Ping Private IP**: **Thất bại hoàn toàn** (vì 2 VPC chưa có đường nối nội bộ).

---
### [LOG THỰC TẾ] Chứng minh kết nối trước khi Peering

Lệnh thực hiện từ máy My VPC (54.179.179.109):
`ssh -i vpcpeering-key.pem ec2-user@54.179.179.109 "ping 52.221.197.42 -c 3; ping 10.10.2.213 -c 3"`

**Kết quả 1: Ping qua Public IP (Thành công)**
`	ext
PING 52.221.197.42 (52.221.197.42) 56(84) bytes of data.
64 bytes from 52.221.197.42: icmp_seq=1 ttl=254 time=0.496 ms
64 bytes from 52.221.197.42: icmp_seq=2 ttl=254 time=0.579 ms
64 bytes from 52.221.197.42: icmp_seq=3 ttl=254 time=0.488 ms

--- 52.221.197.42 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2050ms
`

**Kết quả 2: Ping qua Private IP (Thất bại)**
`	ext
PING 10.10.2.213 (10.10.2.213) 56(84) bytes of data.

--- 10.10.2.213 ping statistics ---
3 packets transmitted, 0 received, 100% packet loss, time 2045ms
`
-> Kết luận: Hai VPC hiện tại hoàn toàn không thể nói chuyện với nhau bằng địa chỉ nội bộ.
---

---
*Bước tiếp theo, chúng mình sẽ đi "xây cầu" (VPC Peering) để thông mạng nội bộ nhé!*


