aws ec2 create-key-pair --key-name tgw-key --query 'KeyMaterial' --output text | Out-File -Encoding ascii -FilePath 'lab/20/tgw-key.pem'
