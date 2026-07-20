# Buoc 6: Kich hoat Cross-Peer DNS

# 1. Lay ten Public DNS cua may HG VPC
aws ec2 describe-instances --instance-ids i-01ec0e0d1416586b4 --query "Reservations[0].Instances[0].PublicDnsName" --output text

# 2. Bật DNS resolution cho Peering Connection
aws ec2 modify-vpc-peering-connection-options `
  --vpc-peering-connection-id pcx-090d74e86be2191f7 `
  --requester-peering-connection-options AllowDnsResolutionFromRemoteVpc=true `
  --accepter-peering-connection-options AllowDnsResolutionFromRemoteVpc=true

# 3. Kiem chung cuoi cung bang cach Ping ten mien DNS
ssh -i vpcpeering-key.pem -o StrictHostKeyChecking=no ec2-user@54.179.179.109 "ping ec2-52-221-197-42.ap-southeast-1.compute.amazonaws.com -c 3"
