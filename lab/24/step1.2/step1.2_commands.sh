#!/bin/bash
# Tạo máy chủ EC2 File Gateway (m5.large)
aws ec2 run-instances \
    --image-id ami-0d54b526d9bf324cf \
    --instance-type m5.large \
    --key-name storagegw-key \
    --security-group-ids sg-0c67fcc5770dbbb75 \
    --subnet-id subnet-004c3d645ff7276a4 \
    --associate-public-ip-address \
    --block-device-mappings '[{"DeviceName":"/dev/sdb","Ebs":{"VolumeSize":150}}]' \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=storagegw-instance}]'
