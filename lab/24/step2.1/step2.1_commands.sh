#!/bin/bash
# Kích hoạt Gateway
aws storagegateway activate-gateway \
    --gateway-name "filesgw" \
    --gateway-timezone "GMT+7:00" \
    --gateway-region "ap-southeast-1" \
    --activation-key "04L9J-4HGA2-AIB6J-GLU14-USISL" \
    --gateway-type FILE_S3

# Đặt mật khẩu Guest cho SMB
aws storagegateway set-smb-guest-password \
    --gateway-arn "arn:aws:storagegateway:ap-southeast-1:120259362620:gateway/sgw-49750D20" \
    --password "Password123!"

# Gán đĩa đệm (Cache)
aws storagegateway add-cache \
    --gateway-arn "arn:aws:storagegateway:ap-southeast-1:120259362620:gateway/sgw-49750D20" \
    --disk-ids "/dev/nvme1n1"
