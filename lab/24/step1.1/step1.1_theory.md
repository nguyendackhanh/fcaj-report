# Lý thuyết Bước 1.1: Tạo S3 Bucket

## Mục tiêu
Tạo một S3 Bucket đóng vai trò là kho lưu trữ dữ liệu (Data Repository) phía sau cho AWS Storage Gateway. Toàn bộ dữ liệu được ghi vào File Share sẽ được đồng bộ trực tiếp lên Bucket này.

## Các thông số quan trọng
- **Bucket Name:** Phải là duy nhất trên toàn cầu (Global Unique). Gợi ý: `s3-instancestoragegw-<tên-của-bạn>-2023`.
- **Region:** `ap-southeast-1` (Singapore) - Cần đồng nhất với vùng triển khai Storage Gateway.
- **Block Public Access:** Giữ mặc định (Bật tất cả) để đảm bảo an toàn, trừ khi có yêu cầu đặc biệt.

## Thao tác trên Console
1. Truy cập dịch vụ S3.
2. Nhấn **Create bucket**.
3. Nhập tên và chọn Region Singapore.
4. Nhấn **Create bucket** ở cuối trang.
