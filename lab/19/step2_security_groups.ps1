# Buoc 2: Tao Security Group va cau hinh Inbound Rules

# 1. Tao MY VPC SG
aws ec2 create-security-group --group-name "MY VPC SG" --description "Security Group for My VPC" --vpc-id vpc-0942fb7e7e76076c4

# 2. Tao HG VPC SG
aws ec2 create-security-group --group-name "HG VPC SG" --description "Security Group for HG VPC" --vpc-id vpc-0f05a1afa7948566d

# 3. Them Inbound Rules cho MY VPC SG (sg-07eb74cd3cacb390b)
aws ec2 authorize-security-group-ingress --group-id sg-07eb74cd3cacb390b --protocol tcp --port 22 --cidr 116.98.254.56/32
aws ec2 authorize-security-group-ingress --group-id sg-07eb74cd3cacb390b --protocol icmp --port -1 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id sg-07eb74cd3cacb390b --protocol icmp --port -1 --cidr 10.10.0.0/16

# 4. Them Inbound Rules cho HG VPC SG (sg-08be10f488891cd7c)
aws ec2 authorize-security-group-ingress --group-id sg-08be10f488891cd7c --protocol tcp --port 22 --cidr 116.98.254.56/32
aws ec2 authorize-security-group-ingress --group-id sg-08be10f488891cd7c --protocol icmp --port -1 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id sg-08be10f488891cd7c --protocol icmp --port -1 --cidr 172.31.0.0/16
