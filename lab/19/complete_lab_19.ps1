# ==============================================================================
# KICH BAN TONG HOP BAI LAB 19: VPC PEERING (FULL COMMANDS)
# ==============================================================================

# --- 0. DINH NGHIA CAC BIEN (Thay doi neu can) ---
$MY_VPC_CIDR = "172.31.0.0/16"
$HG_VPC_CIDR = "10.10.0.0/16"
$REGION = "ap-southeast-1"

# --- BUOC 1: KHOI TAO HA TANG (CloudFormation) ---
# Tao My-VPC-Stack
aws cloudformation create-stack `
  --stack-name My-VPC-Stack `
  --template-body file://AWS-CloudFormation-Template-master/VPCTemplate.yml `
  --parameters `
    ParameterKey=EnvironmentName,ParameterValue="My VPC" `
    ParameterKey=VpcCIDR,ParameterValue=$MY_VPC_CIDR `
    ParameterKey=PublicSubnet1CIDR,ParameterValue=172.31.1.0/24 `
    ParameterKey=PublicSubnet2CIDR,ParameterValue=172.31.2.0/24 `
    ParameterKey=PrivateSubnet1CIDR,ParameterValue=172.31.3.0/24 `
    ParameterKey=PrivateSubnet2CIDR,ParameterValue=172.31.4.0/24

# Tao HG-VPC-Stack
aws cloudformation create-stack `
  --stack-name HG-VPC-Stack `
  --template-body file://AWS-CloudFormation-Template-master/VPCTemplate.yml `
  --parameters `
    ParameterKey=EnvironmentName,ParameterValue="HG VPC" `
    ParameterKey=VpcCIDR,ParameterValue=$HG_VPC_CIDR `
    ParameterKey=PublicSubnet1CIDR,ParameterValue=10.10.1.0/24 `
    ParameterKey=PublicSubnet2CIDR,ParameterValue=10.10.2.0/24 `
    ParameterKey=PrivateSubnet1CIDR,ParameterValue=10.10.3.0/24 `
    ParameterKey=PrivateSubnet2CIDR,ParameterValue=10.10.4.0/24

# --- BUOC 2: TAO SECURITY GROUPS ---
# (Sau khi lay duoc VPC ID, hay chay cac lenh sau)
# aws ec2 create-security-group --group-name "MY VPC SG" --vpc-id <VPC_ID>
# aws ec2 authorize-security-group-ingress --group-id <SG_ID> --protocol tcp --port 22 --cidr <YOUR_IP>/32
# aws ec2 authorize-security-group-ingress --group-id <SG_ID> --protocol icmp --port -1 --cidr 0.0.0.0/0
# aws ec2 authorize-security-group-ingress --group-id <SG_ID> --protocol icmp --port -1 --cidr $HG_VPC_CIDR

# --- BUOC 3: KHOI TAO EC2 ---
# aws ec2 create-key-pair --key-name vpcpeering-key --query 'KeyMaterial' --output text | Out-File -Encoding ascii -FilePath vpcpeering-key.pem
# aws ec2 run-instances --image-id ami-062cf2a54d864b4ca --count 1 --instance-type t2.micro --key-name vpcpeering-key --security-group-ids <SG_ID> --subnet-id <SUBNET_ID>

# --- BUOC 4: CAP NHAT NETWORK ACL (HG VPC) ---
aws ec2 replace-network-acl-entry `
  --network-acl-id acl-0a665f4d7fb818e11 `
  --ingress --rule-number 100 --protocol -1 --rule-action allow --cidr-block $MY_VPC_CIDR

# --- BUOC 5: VPC PEERING & ROUTE TABLE ---
# 5.1. Tao ket noi Peering
aws ec2 create-vpc-peering-connection --vpc-id vpc-0942fb7e7e76076c4 --peer-vpc-id vpc-0f05a1afa7948566d

# 5.2. Chap nhan ket noi (Dung ID pcx-090d74e86be2191f7)
aws ec2 accept-vpc-peering-connection --vpc-peering-connection-id pcx-090d74e86be2191f7

# 5.3. Mo duong cho My VPC (rtb-00bcfeff7dfca4dc3)
aws ec2 create-route --route-table-id rtb-00bcfeff7dfca4dc3 --destination-cidr-block $HG_VPC_CIDR --vpc-peering-connection-id pcx-090d74e86be2191f7

# 5.4. Mo duong cho HG VPC (rtb-01fa8afdbacccd193)
aws ec2 create-route --route-table-id rtb-01fa8afdbacccd193 --destination-cidr-block $MY_VPC_CIDR --vpc-peering-connection-id pcx-090d74e86be2191f7

# --- BUOC 6: KICH HOAT CROSS-PEER DNS ---
aws ec2 modify-vpc-peering-connection-options `
  --vpc-peering-connection-id pcx-090d74e86be2191f7 `
  --requester-peering-connection-options AllowDnsResolutionFromRemoteVpc=true `
  --accepter-peering-connection-options AllowDnsResolutionFromRemoteVpc=true
