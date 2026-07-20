# Buoc 4: Cap nhat Network ACL cho HG VPC

# 1. Thay the Rule 100 de chi cho phep My VPC (172.31.0.0/16) vao cửa
aws ec2 replace-network-acl-entry `
  --network-acl-id acl-0a665f4d7fb818e11 `
  --ingress `
  --rule-number 100 `
  --protocol -1 `
  --rule-action allow `
  --cidr-block 172.31.0.0/16

# 2. Thu nghiem Ping lai tu may My VPC sang Public IP cua HG VPC (Du kien se THAT BAI)
ssh -i vpcpeering-key.pem -o StrictHostKeyChecking=no ec2-user@54.179.179.109 "ping 52.221.197.42 -c 3 -W 2"
