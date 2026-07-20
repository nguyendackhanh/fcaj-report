# Lý thuyết Bước 2.3: Kết nối File shares ở máy On-premise

## Mục tiêu
Sử dụng giao thức SMB để ánh xạ File Share từ AWS về máy tính cá nhân (hoặc máy On-premise) dưới dạng một ổ đĩa mạng.

## Các bước thực hiện
1. **Lấy thông tin:** Cần Public IP của Gateway và tên S3 Bucket.
2. **Mount ổ đĩa:** Sử dụng lệnh `net use` trên Windows (hoặc `mount` trên Linux).
3. **Xác thực:** Nhập mật khẩu Guest đã thiết lập.
4. **Kiểm tra đồng bộ:** 
    - Tạo một file `.txt` trong ổ đĩa mạng vừa mount.
    - Lên AWS S3 Console kiểm tra xem file đó có xuất hiện trong bucket không.

## Thao tác trên Console (Client)
- Mở **Command Prompt (Admin)**.
- Chạy lệnh: `net use Z: \\<Public-IP>\<Bucket-Name> /user:<Gateway-ID>\smbguest`.
- Nhập mật khẩu khi được hỏi.
- Mở **File Explorer**, truy cập ổ `Z:`.
