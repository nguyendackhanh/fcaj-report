# Bước 2: Khởi tạo hạ tầng bằng CloudFormation

Chào bạn! Đây là bước xây dựng nền móng. Chúng mình sẽ dùng file 	gw-lab.yaml để AWS tự động tạo ra 3-4 VPC và các máy chủ EC2 cần thiết cho bài Lab Transit Gateway này.

## 1. Kế hoạch thực hiện
- **Tên Stack**: Lab20-Stack
- **File thiết kế**: lab/20/template_extracted/AWS-Transit-Gateway-Template-master/tgw-lab.yaml
- **Tham số quan trọng**: KeyName=tgw-key (Sử dụng chìa khóa chúng mình vừa tạo ở Bước 1).

## 2. Các lệnh dự kiến sẽ chạy
`powershell
aws cloudformation create-stack `
  --stack-name Lab20-Stack `
  --template-body file://lab/20/template_extracted/AWS-Transit-Gateway-Template-master/tgw-lab.yaml `
  --parameters ParameterKey=KeyName,ParameterValue=tgw-key `
  --capabilities CAPABILITY_IAM
`

---
## 3. Nhật ký thực thi (Đang triển khai)

### Lệnh đã chạy (Sửa đổi tham số SSHKeyName):
`powershell
aws cloudformation create-stack `
  --stack-name Lab20-Stack `
  --template-body file://lab/20/template_extracted/AWS-Transit-Gateway-Template-master/tgw-lab.yaml `
  --parameters ParameterKey=SSHKeyName,ParameterValue=tgw-key `
  --capabilities CAPABILITY_IAM
`

### Phản hồi từ PowerShell:
`json
{
    "StackId": "arn:aws:cloudformation:ap-southeast-1:120259362620:stack/Lab20-Stack/...",
    "OperationId": "..."
}
--- PHAN HOI TU POWERSHELL ---
Lệnh đã gửi thành công. Stack Lab20-Stack đang trong trạng thái CREATE_IN_PROGRESS.
`
---
*Đang đợi AWS hoàn tất việc khởi tạo hạ tầng...*

