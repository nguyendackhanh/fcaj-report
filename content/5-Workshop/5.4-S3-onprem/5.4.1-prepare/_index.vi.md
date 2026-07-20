---
title : "Cấu hình frontend ở local"
date: 2026-06-30
weight : 1
chapter : false
pre : " <b> 5.4.1. </b> "
---

#### Tạo file môi trường

Mở thư mục `frontend` và tạo file `.env` ngang hàng với thư mục `src`.

Điền các giá trị đã copy từ CloudFormation Outputs:

```env
VITE_API_ENDPOINT=https://xxx.execute-api.ap-southeast-1.amazonaws.com/prod
VITE_COGNITO_USER_POOL_ID=ap-southeast-1_xxxxxxxxx
VITE_COGNITO_CLIENT_ID=abc123xyz456
```

#### Build frontend

Mở Terminal và di chuyển vào thư mục frontend (Ví dụ):

```bash
cd "C:\Users\Sieu chu nhiem\Desktop\aws-serverless-event-portal\frontend"
```

Cài đặt dependencies:

```bash
npm install
```

Build các file website tĩnh:

```bash
npm run build
```

Sau khi build xong, thư mục frontend sẽ có thư mục `dist`. Đây là thư mục chứa các file tĩnh cần upload lên Amazon S3.