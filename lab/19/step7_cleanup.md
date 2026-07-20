# Bước 7: Dọn dẹp tài nguyên - "Hoàn trả mặt bằng"

Chào bạn! Bài Lab đã kết thúc thành công. Bây giờ chúng mình sẽ thực hiện dọn dẹp toàn bộ các tài nguyên đã tạo để tránh phát sinh chi phí không đáng có.

## 1. Kế hoạch dọn dẹp
- **Xóa máy chủ EC2**: Phải xóa cái này đầu tiên.
- **Xóa Peering Connection**: Gỡ bỏ kết nối giữa 2 VPC.
- **Xóa Security Groups**: Sau khi máy chủ đã xóa thì mới xóa được SG.
- **Xóa CloudFormation Stacks**: Bước này sẽ xóa VPC và toàn bộ hạ tầng mạng.
- **Xóa Key Pair**: Xóa chìa khóa trên AWS.

## 2. Các lệnh thực thi và Phản hồi (Terminal Log)

### Lệnh xóa EC2:
`	ext
aws ec2 terminate-instances --instance-ids i-0b55928fb572b1c21 i-01ec0e0d1416586b4
Status: shutting-down
`

### Lệnh xóa Peering và Security Groups:
`	ext
aws ec2 delete-vpc-peering-connection --vpc-peering-connection-id pcx-090d74e86be2191f7
Return: true

aws ec2 delete-security-group --group-id sg-07eb74cd3cacb390b
Return: true
`

### Lệnh xóa CloudFormation (VPC):
`	ext
aws cloudformation delete-stack --stack-name My-VPC-Stack
aws cloudformation delete-stack --stack-name HG-VPC-Stack
Status: DELETE_IN_PROGRESS
`

-> **Kết luận**: Tất cả tài nguyên đã được đưa vào quy trình xóa. Tài khoản của bạn sẽ trở lại trạng thái sạch sẽ sau vài phút nữa.
---

