# Bước 3: Dọn dẹp tài nguyên (Cleanup)

## 1. Mục tiêu
Đảm bảo tất cả các tài nguyên đã tạo trong bài lab được xóa bỏ hoàn toàn để:
- **Tránh phát sinh chi phí:** Các tài nguyên như EC2 (m5.large), EBS volume (150GB Cache) và Storage Gateway sẽ tính phí theo thời gian sử dụng.
- **Giữ môi trường sạch sẽ:** Không để lại các tài nguyên rác trong tài khoản AWS.

## 2. Các tài nguyên cần xóa
Thứ tự xóa rất quan trọng vì các tài nguyên có sự phụ thuộc lẫn nhau:
1. **File Share:** Phải xóa File Share trước để ngắt kết nối giữa Gateway và S3 Bucket.
2. **Storage Gateway:** Xóa Gateway sau khi đã xóa hết các File Share thuộc về nó.
3. **EC2 Instance:** Terminate máy chủ đang chạy phần mềm Gateway.
4. **S3 Bucket:** Xóa Bucket cùng toàn bộ dữ liệu thực hành bên trong.
5. **Security Group:** Chỉ xóa được sau khi EC2 đã bị terminate hoàn toàn.
6. **Key Pair:** Xóa khóa truy cập đã tạo.

## 3. Lưu ý quan trọng
- Khi xóa S3 Bucket bằng lệnh CLI với cờ `--force`, toàn bộ dữ liệu bên trong sẽ bị xóa vĩnh viễn.
- Luôn kiểm tra lại trên giao diện AWS Console để đảm bảo không còn tài nguyên nào ở trạng thái **Running** hoặc **Available**.
