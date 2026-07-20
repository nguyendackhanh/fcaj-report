# Buoc 7: Don dep tai nguyen Lab 20

# Xoa Attachments
aws ec2 delete-transit-gateway-vpc-attachment --transit-gateway-attachment-id tgw-attach-0fe13b6f145a1c81e
aws ec2 delete-transit-gateway-vpc-attachment --transit-gateway-attachment-id tgw-attach-0330053f3c9b202d7
aws ec2 delete-transit-gateway-vpc-attachment --transit-gateway-attachment-id tgw-attach-0fdae308e1e1d7a44
aws ec2 delete-transit-gateway-vpc-attachment --transit-gateway-attachment-id tgw-attach-0f29921a698e6059c

# Xoa TGW Route Table
aws ec2 delete-transit-gateway-route-table --transit-gateway-route-table-id tgw-rtb-0709ceabfe0f42742

# Xoa Transit Gateway
aws ec2 delete-transit-gateway --transit-gateway-id tgw-058ef8d76a862176e

# Xoa CloudFormation Stack
aws cloudformation delete-stack --stack-name Lab20-Stack

# Xoa Key Pair
aws ec2 delete-key-pair --key-name tgw-key
