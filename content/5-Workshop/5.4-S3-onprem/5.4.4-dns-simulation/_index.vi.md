---
title : "Upload frontend files"
date: 2026-06-30
weight : 4
chapter : false
pre : " <b> 5.4.4. </b> "
---

#### Upload kết quả build

1. Mở frontend S3 bucket.
2. Chuyển sang tab **Objects**.
3. Chọn **Upload**.
4. Chọn toàn bộ file và thư mục nằm bên trong thư mục `dist` của frontend ở local.
5. Upload chúng lên bucket.

![Upload frontend files](/images/5-Workshop/event-portal/08-upload-frontend-files.png)

#### Kiểm tra website

Mở **Bucket website endpoint** đã copy ở bước trước. Frontend của Event Portal sẽ được tải và kết nối với serverless backend thông qua API endpoint đã cấu hình trong file `.env`.

Nếu trang load được nhưng dữ liệu API không hiển thị, hãy kiểm tra lại các giá trị sau:

- `VITE_API_ENDPOINT`
- `VITE_COGNITO_USER_POOL_ID`
- `VITE_COGNITO_CLIENT_ID`
- Bucket policy và public access settings của S3