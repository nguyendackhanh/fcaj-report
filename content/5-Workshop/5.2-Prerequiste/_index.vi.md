---
title : "Chuẩn bị backend code"
date: 2026-06-30
weight : 2 
chapter : false
pre : " <b> 5.2. </b> "
---

#### Mục đích

Ở bước này, ta đóng gói source code backend và upload lên Amazon S3. Sau đó CloudFormation sẽ sử dụng package này để tự động tạo các Lambda functions.

#### 1. Build backend code ở local

1. Mở Terminal hoặc Command Prompt.
2. Di chuyển vào thư mục backend (Ví dụ):

```bash
cd "C:\Users\Sieu chu nhiem\Desktop\aws-serverless-event-portal\backend"
```

3. Cài đặt dependencies:

```bash
npm install
```

4. Build source code TypeScript sang JavaScript:

```bash
npm run build
```

5. Sau khi build xong, thư mục backend sẽ sinh ra thư mục `dist`.
6. Copy `package.json` và `node_modules` vào trong thư mục `dist`.
7. Nén toàn bộ file bên trong `dist` thành package, ví dụ `backend-code.zip` hoặc `backend.rar`.

#### 2. Tạo S3 bucket để chứa backend package

Mở Amazon S3 console và tạo bucket ở Region **Asia Pacific (Singapore) ap-southeast-1**. Trong workshop này, backend package được upload vào bucket tên `buketbackend`.

![Tạo backend bucket](/images/5-Workshop/event-portal/01-create-backend-bucket.png)

#### 3. Upload backend package

Mở bucket, chọn **Upload**, chọn file backend đã nén và upload lên S3.

![Upload backend package](/images/5-Workshop/event-portal/02-upload-backend-code.png)

#### 4. Copy Object URL hoặc S3 URI

Sau khi upload thành công, mở object vừa upload và copy **Object URL** hoặc **S3 URI**. Giá trị này sẽ được dùng trong file `template.yaml`.

![Copy backend object URL](/images/5-Workshop/event-portal/03-copy-backend-object-url.png)

Ví dụ Object URL:

```text
https://buketbackend.s3.ap-southeast-1.amazonaws.com/backend.rar
```

Sau bước này, cần lưu lại backend package URL để dùng ở bước triển khai CloudFormation.