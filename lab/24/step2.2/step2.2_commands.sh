#!/bin/bash
# Tạo File Share kết nối tới S3
aws storagegateway create-smb-file-share \
    --gateway-arn "arn:aws:storagegateway:ap-southeast-1:120259362620:gateway/sgw-49750D20" \
    --location-arn "arn:aws:s3:::s3-instancestoragegw-sieuchunhiem-2023" \
    --role "arn:aws:iam::120259362620:role/StorageGatewayS3Role" \
    --authentication "GuestAccess" \
    --region "ap-southeast-1" \
    --client-token "1714971378"
