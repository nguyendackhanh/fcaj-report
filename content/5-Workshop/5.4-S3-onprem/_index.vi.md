---
title : "Triển khai frontend bằng Amazon S3"
date: 2026-06-30
weight : 4
chapter : false
pre : " <b> 5.4. </b> "
---

#### Tổng quan

Trong phần này, ta triển khai frontend của Event Portal dưới dạng static website trên Amazon S3. CloudFormation đã tạo sẵn frontend bucket, vì vậy ta chỉ cần cấu hình biến môi trường ở local, build frontend, bật quyền public website access và upload các file đã build.

#### Nội dung

- [Cấu hình frontend ở local](5.4.1-prepare/)
- [Cấu hình quyền cho frontend S3 bucket](5.4.2-create-interface-enpoint/)
- [Bật static website hosting](5.4.3-test-endpoint/)
- [Upload frontend files và kiểm tra website](5.4.4-dns-simulation/)