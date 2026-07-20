# Buoc 5: Cau hinh Transit Gateway Route Table

# 1. Tao Route Table
aws ec2 create-transit-gateway-route-table --transit-gateway-id tgw-058ef8d76a862176e --tag-specifications "ResourceType=transit-gateway-route-table,Tags=[{Key=Name,Value=lab20-TGW-RT}]"

# 2. Association cho 4 VPC
aws ec2 associate-transit-gateway-route-table --transit-gateway-route-table-id tgw-rtb-0709ceabfe0f42742 --transit-gateway-attachment-id tgw-attach-0fe13b6f145a1c81e
aws ec2 associate-transit-gateway-route-table --transit-gateway-route-table-id tgw-rtb-0709ceabfe0f42742 --transit-gateway-attachment-id tgw-attach-0330053f3c9b202d7
aws ec2 associate-transit-gateway-route-table --transit-gateway-route-table-id tgw-rtb-0709ceabfe0f42742 --transit-gateway-attachment-id tgw-attach-0fdae308e1e1d7a44
aws ec2 associate-transit-gateway-route-table --transit-gateway-route-table-id tgw-rtb-0709ceabfe0f42742 --transit-gateway-attachment-id tgw-attach-0f29921a698e6059c

# 3. Propagation cho 4 VPC
aws ec2 enable-transit-gateway-route-table-propagation --transit-gateway-route-table-id tgw-rtb-0709ceabfe0f42742 --transit-gateway-attachment-id tgw-attach-0fe13b6f145a1c81e
aws ec2 enable-transit-gateway-route-table-propagation --transit-gateway-route-table-id tgw-rtb-0709ceabfe0f42742 --transit-gateway-attachment-id tgw-attach-0330053f3c9b202d7
aws ec2 enable-transit-gateway-route-table-propagation --transit-gateway-route-table-id tgw-rtb-0709ceabfe0f42742 --transit-gateway-attachment-id tgw-attach-0fdae308e1e1d7a44
aws ec2 enable-transit-gateway-route-table-propagation --transit-gateway-route-table-id tgw-rtb-0709ceabfe0f42742 --transit-gateway-attachment-id tgw-attach-0f29921a698e6059c
