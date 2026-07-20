#(https://000019.awsstudygroup.com/vi/2-prerequiste/)
# BÆ°á»›c 1: Khá»Ÿi táº¡o háº¡ táº§ng VPC báº±ng CloudFormation

Trong bÆ°á»›c nÃ y, chÃºng ta sá»­ dá»¥ng AWS CLI Ä‘á»ƒ triá»ƒn khai hai Stack CloudFormation tá»« template `VPCTemplate.yml`. Viá»‡c nÃ y giÃºp tá»± Ä‘á»™ng hÃ³a quÃ¡ trÃ¬nh táº¡o VPC, Subnet, Internet Gateway vÃ  Route Tables.

## 1. CÃ¡c lá»‡nh Ä‘Ã£ thá»±c hiá»‡n

### Táº¡o My-VPC-Stack (VPC 1)
- **Dáº£i IP**: 172.31.0.0/16
- **Lá»‡nh**:
```powershell
aws cloudformation create-stack `
  --stack-name My-VPC-Stack `
  --template-body file://AWS-CloudFormation-Template-master/VPCTemplate.yml `
  --parameters `
    ParameterKey=EnvironmentName,ParameterValue="My VPC" `
    ParameterKey=VpcCIDR,ParameterValue=172.31.0.0/16 `
    ParameterKey=PublicSubnet1CIDR,ParameterValue=172.31.1.0/24 `
    ParameterKey=PublicSubnet2CIDR,ParameterValue=172.31.2.0/24 `
    ParameterKey=PrivateSubnet1CIDR,ParameterValue=172.31.3.0/24 `
    ParameterKey=PrivateSubnet2CIDR,ParameterValue=172.31.4.0/24
```

### Táº¡o HG-VPC-Stack (VPC 2)
- **Dáº£i IP**: 10.10.0.0/16
- **Lá»‡nh**:
```powershell
aws cloudformation create-stack `
  --stack-name HG-VPC-Stack `
  --template-body file://AWS-CloudFormation-Template-master/VPCTemplate.yml `
  --parameters `
    ParameterKey=EnvironmentName,ParameterValue="HG VPC" `
    ParameterKey=VpcCIDR,ParameterValue=10.10.0.0/16 `
    ParameterKey=PublicSubnet1CIDR,ParameterValue=10.10.1.0/24 `
    ParameterKey=PublicSubnet2CIDR,ParameterValue=10.10.2.0/24 `
    ParameterKey=PrivateSubnet1CIDR,ParameterValue=10.10.3.0/24 `
    ParameterKey=PrivateSubnet2CIDR,ParameterValue=10.10.4.0/24
```

## 2. Káº¿t quáº£ Ä‘áº¡t Ä‘Æ°á»£c

Sau khi Stack hoÃ n táº¥t (`CREATE_COMPLETE`), chÃºng ta cÃ³ cÃ¡c thÃ´ng sá»‘ sau:

| TÃ i nguyÃªn | My-VPC-Stack | HG-VPC-Stack |
| :--- | :--- | :--- |
| **VPC ID** | `vpc-0942fb7e7e76076c4` | `vpc-0f05a1afa7948566d` |
| **Public Subnet 1** | `subnet-003cd87101f275304` | `subnet-0d4f7242bc544d3e0` |

---
*Ghi chÃº: LuÃ´n Ä‘áº£m báº£o báº¡n Ä‘ang á»Ÿ Region ap-southeast-1 (Singapore).*

