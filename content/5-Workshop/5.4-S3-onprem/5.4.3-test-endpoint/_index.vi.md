---
title : "Bật static website hosting"
date: 2026-06-30
weight : 3
chapter : false
pre : " <b> 5.4.3. </b> "
---

#### Bật website hosting

1. Mở frontend S3 bucket.
2. Chuyển sang tab **Properties**.
3. Kéo xuống phần **Static website hosting** và chọn **Edit**.
4. Chọn **Enable**.
5. Chọn **Host a static website**.
6. Nhập các giá trị sau:
   - **Index document:** `index.html`
   - **Error document:** `index.html`
7. Lưu thay đổi.

![Bật static website hosting](/images/5-Workshop/event-portal/06-enable-static-website-hosting.png)

#### Copy website endpoint

Sau khi bật hosting, copy **Bucket website endpoint**. Đây là URL dùng để truy cập frontend sau khi triển khai.

![Copy website endpoint](/images/5-Workshop/event-portal/07-copy-website-endpoint.png)