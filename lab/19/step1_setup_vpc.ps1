# Buoc 1: Khoi tao 2 VPC bang CloudFormation

# 1. Tao My-VPC-Stack (172.31.0.0/16)
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

# 2. Tao HG-VPC-Stack (10.10.0.0/16)
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

# 3. Cho doi va kiem tra ket qua
aws cloudformation wait stack-create-complete --stack-name My-VPC-Stack
aws cloudformation wait stack-create-complete --stack-name HG-VPC-Stack
