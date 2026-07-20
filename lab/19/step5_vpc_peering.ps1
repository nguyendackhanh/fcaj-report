# Buoc 5: Thuc thi VPC Peering va Route Table

# 1. Tao ket noi Peering
aws ec2 create-vpc-peering-connection `
  --vpc-id vpc-0942fb7e7e76076c4 `
  --peer-vpc-id vpc-0f05a1afa7948566d `
  --tag-specifications 'ResourceType=vpc-peering-connection,Tags=[{Key=Name,Value=lab-vpc-peer}]'

# 2. Chap nhan ket noi (Dung ID pcx-090d74e86be2191f7 vua tao)
aws ec2 accept-vpc-peering-connection --vpc-peering-connection-id pcx-090d74e86be2191f7

# 3. Them Route cho My VPC (rtb-00bcfeff7dfca4dc3) sang HG VPC (10.10.0.0/16)
aws ec2 create-route `
  --route-table-id rtb-00bcfeff7dfca4dc3 `
  --destination-cidr-block 10.10.0.0/16 `
  --vpc-peering-connection-id pcx-090d74e86be2191f7

# 4. Them Route cho HG VPC (rtb-01fa8afdbacccd193) sang My VPC (172.31.0.0/16)
aws ec2 create-route `
  --route-table-id rtb-01fa8afdbacccd193 `
  --destination-cidr-block 172.31.0.0/16 `
  --vpc-peering-connection-id pcx-090d74e86be2191f7

# 5. Kiem chung cuoi cung
ssh -i vpcpeering-key.pem -o StrictHostKeyChecking=no ec2-user@54.179.179.109 "ping 10.10.2.213 -c 3"
