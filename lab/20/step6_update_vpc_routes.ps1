# Buoc 6: Cap nhat Route Table cua tung VPC

# VPC1
aws ec2 create-route --route-table-id rtb-0d6f8ffd7e4838bdb --destination-cidr-block 172.16.0.0/16 --transit-gateway-id tgw-058ef8d76a862176e

# VPC2
aws ec2 create-route --route-table-id rtb-00a8ff7627e17e556 --destination-cidr-block 0.0.0.0/0 --transit-gateway-id tgw-058ef8d76a862176e

# VPC3
aws ec2 create-route --route-table-id rtb-014fb19f8c2c3eba3 --destination-cidr-block 172.16.0.0/16 --transit-gateway-id tgw-058ef8d76a862176e

# VPC4
aws ec2 create-route --route-table-id rtb-02caf6f1bd7f5f4f9 --destination-cidr-block 0.0.0.0/0 --transit-gateway-id tgw-058ef8d76a862176e
