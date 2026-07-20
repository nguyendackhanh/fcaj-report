#!/bin/bash
# Lệnh dọn dẹp tài nguyên
aws storagegateway delete-file-share --file-share-arn "$SHARE_ARN" --force-delete
aws storagegateway delete-gateway --gateway-arn "$GATEWAY_ARN"
aws ec2 terminate-instances --instance-ids $INSTANCE_IDS
aws s3 rb s3://$BUCKET_NAME --force
