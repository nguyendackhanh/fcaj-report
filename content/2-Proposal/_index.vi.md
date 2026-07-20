---
title: "Bản đề xuất"
date: 2026-06-30
weight: 2
chapter: false
pre: " <b> 2. </b> "
---

# AWS Serverless Event Management Portal 
## Giải pháp Cổng thông tin Quản lý và Đăng ký Sự kiện Trực tuyến

### 1. Tóm tắt điều hành  
AWS Serverless Event Management Portal là một giải pháp quản lý sự kiện toàn diện, được thiết kế với mô hình kiến trúc không máy chủ (Serverless 100%) trên nền tảng AWS. Hệ thống cung cấp cổng thông tin cho phép người dùng đăng ký sự kiện, quản lý danh sách chờ (waitlist), điểm danh bằng mã QR, nhận gợi ý sự kiện và đánh giá sau sự kiện. Với việc tận dụng triệt để AWS Free Tier (Always Free & 12 Months Free), giải pháp này mang lại hiệu năng cao, bảo mật tốt mà chi phí vận hành hàng tháng xấp xỉ 0 USD.

### 2. Tuyên bố vấn đề  
*Vấn đề hiện tại*  
Các hệ thống quản lý sự kiện truyền thống thường tốn kém chi phí duy trì máy chủ (EC2, RDS) liên tục ngay cả khi không có người dùng, thiếu tính linh hoạt khi lưu lượng truy cập tăng đột biến, và gặp nhiều khó khăn trong khâu quản lý điểm danh vé tự động hay tích hợp danh sách chờ.

*Giải pháp đề xuất*  
Xây dựng một kiến trúc hướng sự kiện (Event-Driven Architecture) bằng cách sử dụng các dịch vụ lõi của AWS. Giao diện web tĩnh (React/Vite) được phân phối qua Amazon S3 và CloudFront. Các luồng xử lý phía backend (API) được thực hiện bởi Amazon API Gateway kết nối với AWS Lambda, truy xuất dữ liệu từ Amazon DynamoDB (Single-Table Design). Hệ thống xác thực người dùng được giao cho Amazon Cognito, giúp giảm tải hoàn toàn việc quản lý bảo mật và server.

*Lợi ích và hoàn vốn đầu tư (ROI)*  
Giải pháp tạo ra nền tảng chuyên nghiệp với 12 API endpoints có sẵn, tích hợp điểm danh bằng mã QR, gợi ý sự kiện, và bảo mật cấp doanh nghiệp. Với mô hình trả tiền theo lưu lượng thực tế (Pay-as-you-go) và tối ưu hóa AWS Free Tier, chi phí hàng tháng được duy trì ở mức 0 USD. Quá trình tự động hóa các thao tác thủ công và khả năng triển khai tức thì qua CloudFormation/SAM giúp tăng năng suất và thu hồi vốn đầu tư nhanh chóng.

### 3. Kiến trúc giải pháp  
Hệ thống vận hành theo cơ chế **Event-Driven Architecture**, chỉ kích hoạt tài nguyên khi có yêu cầu.

![Architecture](/images/event_portal_architecture.jpg)

*Dịch vụ AWS sử dụng chính*  
- **Amazon S3 & CloudFront**: Lưu trữ và phân phối giao diện web tĩnh (Frontend).  
- **Amazon Cognito**: Quản lý tài khoản, phân quyền User/Admin và cung cấp JWT Token.  
- **Amazon API Gateway**: Cổng giao tiếp REST API xử lý JWT và phân luồng.  
- **AWS Lambda**: Thực thi logic nghiệp vụ (12 functions viết bằng Node.js/TypeScript).  
- **Amazon DynamoDB**: Cơ sở dữ liệu NoSQL với thiết kế Single-Table Design tối ưu hiệu năng.  
- **Amazon CloudWatch**: Giám sát (Monitoring), lưu trữ Log và thiết lập Alarm.  

*Luồng dữ liệu cơ bản*  
1. Người dùng truy cập tên miền, tải trang tĩnh từ S3 qua CloudFront.
2. Xác thực tài khoản qua Cognito để nhận JWT Token.
3. Gửi request kèm Token lên API Gateway.
4. API Gateway kiểm tra Token, gọi Lambda function tương ứng.
5. Lambda đọc/ghi dữ liệu vào DynamoDB và trả kết quả về cho frontend.

### 4. Triển khai kỹ thuật  
Dự án được chia thành hai phần chính: Backend và Frontend, được triển khai hoàn toàn tự động hoặc bán tự động.

*Backend (AWS SAM/CloudFormation)*  
- **Nền tảng**: Node.js/TypeScript.
- **Tính năng**: 12 Lambda functions hỗ trợ đăng ký, waitlist, QR check-in, gợi ý, export file .ics.
- **Database**: Single-Table Design với 2 GSIs (Global Secondary Indexes) để hỗ trợ 17 thực thể, dùng DynamoDB Streams để đồng bộ số vé trống.
- **Triển khai**: Đóng gói mã nguồn và sử dụng AWS CloudFormation (`template.yaml`) để dựng tự động toàn bộ hạ tầng backend (DynamoDB, API, Lambda, Cognito).

*Frontend (Vite/React)*  
- **Giao diện**: Xây dựng với Vite/React, gồm các tính năng như Protected Routes, Waitlist UI, Profile, QR Check-in Page, Review Rating Component.
- **Triển khai**: Build ra các file tĩnh (HTML, CSS, JS) và upload lên Amazon S3, kích hoạt tính năng Static Website Hosting.

### 5. Lộ trình & Mốc triển khai  
Dự án được thực hiện và hoàn thành trong vòng 4 tuần:
- **Tuần 1**: Thiết lập nền tảng, cơ sở dữ liệu DynamoDB, API cơ bản và Protected Routes (Frontend).  
- **Tuần 2**: Hoàn thiện tính năng đăng ký, xác thực Cognito, Waitlist UI và User Profile.  
- **Tuần 3**: Quản lý sự kiện cho Admin, điểm danh QR (QR Check-in), Đánh giá/Review.  
- **Tuần 4**: Các tính năng nâng cao (Gợi ý sự kiện, Xuất lịch .ics, Danh sách thành viên) và tối ưu CloudFormation.

### 6. Ước tính ngân sách  
Được thiết kế để tận dụng tối đa gói miễn phí (AWS Free Tier):  
- **AWS Lambda**: 1 triệu requests/tháng, 400.000 GB-seconds -> $0  
- **Amazon DynamoDB**: 25 GB storage, 25 RCU/WCU -> $0  
- **Amazon CloudWatch**: 5 GB logs, 10 alarms -> $0  
- **Amazon S3**: 5 GB storage tĩnh -> $0  
- **Amazon Cognito**: Lên tới 50.000 Monthly Active Users -> $0  
- **Amazon API Gateway**: Tính phí sau 12 tháng (hoặc vượt ngưỡng), khoảng $3.50/1 triệu requests.  

*Tổng chi phí hàng tháng (với lưu lượng startup thông thường)*: **~ 0 USD**.

### 7. Đánh giá rủi ro  
*Ma trận rủi ro & Chiến lược giảm thiểu*  
- **Khởi động lạnh (Cold Starts) của Lambda**:  
  - *Giải pháp*: Tối ưu gói code (giữ bộ nhớ Lambda nhỏ gọn), tải sẵn kết nối DynamoDB.  
- **Quá tải Database (Throttling)**:  
  - *Giải pháp*: Cài đặt Auto Scaling cho DynamoDB hoặc chuyển sang chế độ On-Demand nếu lưu lượng thực tế khó dự đoán.  
- **Vượt ngân sách ngoài ý muốn**:  
  - *Giải pháp*: Thiết lập CloudWatch Billing Alarms cảnh báo ngay khi chi phí > $10.

### 8. Kết quả kỳ vọng  
Một hệ thống quản lý sự kiện chuyên nghiệp, toàn diện theo tiêu chuẩn doanh nghiệp (Enterprise-Grade Standard), chịu tải cao và sẵn sàng đưa vào vận hành (Production-ready). Hệ thống hỗ trợ tốt luồng công việc từ lúc tạo sự kiện, khách hàng đăng ký, đến điểm danh thực tế, mang lại trải nghiệm mượt mà và tối giản chi phí hạ tầng.