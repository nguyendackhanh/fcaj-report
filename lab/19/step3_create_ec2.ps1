# Buoc 3: Tao EC2 Instances de chuan bi test ket noi

# 1. Tao Key Pair (Dung de SSH vao may chu sau nay)
aws ec2 create-key-pair --key-name vpcpeering-key --query 'KeyMaterial' --output text | Out-File -Encoding ascii -FilePath vpcpeering-key.pem

# 2. Tim AMI ID cua Amazon Linux 2 moi nhat
aws ec2 describe-images --owners amazon --filters "Name=name,Values=amzn2-ami-hvm-2.0.*-x86_64-gp2" --query "sort_by(Images, &CreationDate)[-1].ImageId" --output text

# 3. Chay may chu EC2 - My VPC
aws ec2 run-instances `
  --image-id ami-062cf2a54d864b4ca `
  --count 1 `
  --instance-type t2.micro `
  --key-name vpcpeering-key `
  --security-group-ids sg-07eb74cd3cacb390b `
  --subnet-id subnet-00a2b6c610e5128bc `
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value="EC2 - My VPC"}]'

# 4. Chay may chu EC2 - HG VPC
aws ec2 run-instances `
  --image-id ami-062cf2a54d864b4ca `
  --count 1 `
  --instance-type t2.micro `
  --key-name vpcpeering-key `
  --security-group-ids sg-08be10f488891cd7c `
  --subnet-id subnet-01efac04064362b5e `
  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value="EC2 - HG VPC"}]'

# 5. Cho may chu chay xong va lay IP
aws ec2 wait instance-running --instance-ids i-0b55928fb572b1c21 i-01ec0e0d1416586b4
