# Buoc 7: Don dep tai nguyen Lab 19

# 1. Xoa EC2 Instances
aws ec2 terminate-instances --instance-ids i-062e78749a0e66887 i-01ec0e0d1416586b4

# 2. Xoa Peering Connection
aws ec2 delete-vpc-peering-connection --vpc-peering-connection-id pcx-090d74e86be2191f7

# 3. Xoa Security Groups
aws ec2 delete-security-group --group-id sg-07eb74cd3cacb390b
aws ec2 delete-security-group --group-id sg-08be10f488891cd7c

# 4. Xoa CloudFormation Stacks
aws cloudformation delete-stack --stack-name My-VPC-Stack
aws cloudformation delete-stack --stack-name HG-VPC-Stack

# 5. Xoa Key Pair tren AWS
aws ec2 delete-key-pair --key-name vpcpeering-key

# 6. Xoa file key duoi may local
Remove-Item -Path "vpcpeering-key.pem" -Force
