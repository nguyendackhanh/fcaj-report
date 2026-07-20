# Phần 3: Hướng dẫn sử dụng & Các câu lệnh cốt lõi

> [!IMPORTANT]
> Phần này cung cấp các lệnh thực tế để bạn demo trực tiếp trong bài thuyết trình.

---

## 1. Lệnh Kiểm tra Hệ thống & Cài đặt
* **Kiểm tra sức khỏe cấu hình:**
  ```powershell
  lean-ctx doctor
  ```
  *Lệnh này sẽ quét toàn bộ hệ thống để đảm bảo nhị phân, đường dẫn môi trường, và các cấu hình MCP cho các IDE đều hoạt động hoàn hảo.*

* **Xem trạng thái hoạt động hiện tại:**
  ```powershell
  lean-ctx status
  ```
  *Hiển thị số lượng MCP Server đã được kích hoạt, phiên bản và các tệp báo cáo.*

---

## 2. Kích hoạt và tùy chỉnh mức độ nén
* **Bật nén tối đa cho phản hồi của AI (Tiết kiệm token tối đa):**
  ```powershell
  lean-ctx terse max
  ```
* **Chuyển đổi các chế độ nén:**
  * `lean-ctx terse standard`: Nén ở mức cân bằng (mặc định).
  * `lean-ctx terse off`: Tắt tính năng nén phản hồi văn bản của AI.

---

## 3. Khởi tạo tích hợp AI Agent
* **Tự động cấu hình cho Antigravity (Gemini):**
  ```powershell
  lean-ctx init --agent antigravity
  ```
* **Các AI hỗ trợ khác:**
  ```powershell
  lean-ctx init --agent cursor
  lean-ctx init --agent claude
  lean-ctx init --agent cline
  ```

---

## 4. Xem báo cáo tài chính & Token tiết kiệm
Một trong những điểm cực kỳ hấp dẫn của `lean-ctx` là cho phép bạn đo lường chính xác lượng tài nguyên đã tiết kiệm.

* **Xem bảng thống kê nhanh trên Terminal:**
  ```powershell
  lean-ctx gain
  ```
* **Xem biểu đồ 30 ngày qua:**
  ```powershell
  lean-ctx gain --graph
  ```
* **Báo cáo tổng kết dạng "Wrapped" siêu đẹp:**
  ```powershell
  lean-ctx gain --wrapped
  ```

---

## 5. Khởi chạy Web Dashboard trực quan
Bạn có thể mở giao diện Web cực kỳ chuyên nghiệp để làm slide trình chiếu trực quan:
```powershell
lean-ctx dashboard
```
* Bảng điều khiển sẽ tự động chạy tại cổng **`3333`** (`http://localhost:3333`).
* Giao diện cung cấp cái nhìn chi tiết về:
  1. Số lượng Token đã tiết kiệm (Input & Output).
  2. Số tiền USD ước tính đã tiết kiệm được dựa trên giá API thực tế.
  3. Lịch sử các lệnh đã được tối ưu hóa.
