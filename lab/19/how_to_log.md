# Bí kíp ghi Log Terminal trong PowerShell

Chào bạn! Đây là 2 cách ghi log "thần thánh" mà chúng mình đã thống nhất để dùng cho các bài Lab sau.

## Cách 1: Vừa xem vừa ghi (Dùng Tee-Object)
Dùng khi bạn muốn chạy từng lệnh và thấy ngay kết quả trên màn hình, đồng thời lưu lại để làm báo cáo.

**Cú pháp:**
`powershell
<Lệnh của bạn> | Tee-Object -FilePath "ten_file_log.txt" -Append
`
*Giải thích:*
- -FilePath: Đường dẫn file muốn lưu.
- -Append: Ghi tiếp vào cuối file (không xóa nội dung cũ).

---

## Cách 2: Quay phim toàn bộ (Dùng Start-Transcript)
Dùng khi bạn muốn ghi lại toàn bộ "buổi diễn" từ lúc bắt đầu đến lúc kết thúc mà không cần gõ lệnh lưu cho từng dòng.

**Cú pháp:**
`powershell
# 1. Bat dau quay
Start-Transcript -Path "nhat_ky_toan_bo_lab.txt"

# 2. Chạy tất cả các lệnh của bạn ở đây...
aws s3 ls
aws ec2 describe-vpcs

# 3. Ket thuc quay
Stop-Transcript
`

---
*Chúc bạn chinh phục các bài Lab AWS thật hiệu quả!*
