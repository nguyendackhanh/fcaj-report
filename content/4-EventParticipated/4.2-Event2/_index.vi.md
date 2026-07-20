---
title: "Event 2: AWS Community Day 2026"
date: 2026-05-23
weight: 2
chapter: false
pre: " <b> 4.2. </b> "
---
#### Một số hình ảnh khi tham gia sự kiện



### Mục Đích Của Sự Kiện

- **Cập nhật công nghệ tiên tiến:** Tiếp cận các xu hướng công nghệ đám mây hiện đại, tối ưu hóa hệ thống CDN và tăng cường bảo mật hạ tầng doanh nghiệp.
- **Nghiên cứu ứng dụng Generative AI thế hệ mới:** Tìm hiểu sâu về kỹ thuật ngữ cảnh (Context Engineering), tính phi xác định trong LLMs và mô hình Multi-Agent Systems cấp doanh nghiệp.
- **Định hướng nghề nghiệp và kết nối cộng đồng:** Học hỏi từ các câu chuyện thực chiến của chuyên gia và kết nối mạng lưới với cộng đồng công nghệ AWS Việt Nam.

---

### Danh Sách Diễn Giả

- **Anh Tín Trương** - Platform Engineer tại Gotadi (Diễn giả phiên *"Context Is Everything"*)
- **Đội ngũ phát triển UTMorpho** - Đại diện đội thi đạt giải LotusHacks (Diễn giả phiên *"36 hrs with LotusHacks"*)
- **Chuyên gia hạ tầng AWS** - Solutions Architect AWS (Diễn giả phiên *"From Edge To Origin: CloudFront"*)
- **Đội ngũ giải pháp dữ liệu AWS** - Technical Specialist AWS (Diễn giả phiên *"Friendly AI Assistant with Amazon Quick"*)
- **Bạn Đức Đào** - Cloud Phoenix Specialist (Diễn giả phiên *"Non-Determinism of LLM Settings"*)
- **Chuyên gia Kiến trúc AI** - Enterprise Solutions Architect (Diễn giả phiên *"Enterprise-Grade Multi-Agent System"*)

---

### Nội Dung Nổi Bật

#### 1. Tầm quan trọng của Bối cảnh trong AI (Context Engineering) & Xu hướng tương lai
- **Lầm tưởng và thực tế về AI:** AI sở hữu kho kiến thức khổng lồ nhưng sẽ thất bại (đưa ra câu trả lời chung chung hoặc ảo tưởng) nếu thiếu đi ngữ cảnh chi tiết. Việc thiết kế ngữ cảnh (Context Engineering) như xác định vai trò cụ thể cho AI mang lại phản hồi vượt trội hơn hẳn so với việc nhồi nhét tài liệu dài loãng cửa sổ ngữ cảnh.
- **Second AI Brain (Bộ não AI thứ hai):** Sự dịch chuyển mạnh mẽ từ việc gõ prompt tức thời sang khả năng ghi nhớ dài hạn bằng cách tích hợp các công cụ ghi chú (Obsidian) với AI để truy xuất dữ liệu tự động.
- **Nghịch lý Jevons trong Kỷ nguyên AI (Ví dụ bóng đèn LED):** Khi công nghệ giúp việc tạo phần mềm trở nên cực kỳ rẻ và nhanh (từ 0 đến 1), số lượng phần mềm sẽ bùng nổ. Nhu cầu công việc sẽ dịch chuyển mạnh mẽ sang việc vận hành, bảo mật, tích hợp và tối ưu hóa hệ thống từ 1 đến N.

#### 2. Hành trình 36 giờ cùng LotusHacks – Xây dựng UTMorpho từ Ý tưởng đến Thực tế
- **Ý chí tham gia và động não (Brainstorming):** Chia sẻ thực tế của đội thi về việc bắt đầu từ số 0 để tìm kiếm ý tưởng sáng tạo độc đáo tại cuộc thi LotusHacks.
- **Định hình sản phẩm & Xây dựng dưới áp lực:** Quá trình phân tích vấn đề thực tế, định hình kiến trúc UTMorpho và vượt qua các lỗi kỹ thuật phát sinh (failures) trong 36 giờ code liên tục đầy căng thẳng.
- **Demo sản phẩm & Bài học:** Giới thiệu tổng quan về MVP của UTMorpho, các bước ngoặt chiến thắng (turning points) và lộ trình phát triển.

#### 3. Tối ưu hóa hạ tầng và tăng tốc ứng dụng tại vùng biên (Edge Computing & CloudFront)
- **CloudFront là nền tảng cốt lõi:** Đóng vai trò là dịch vụ CDN phân phối nội dung tĩnh và động toàn cầu với độ trễ tối thiểu nhờ mạng lưới điểm biên rộng lớn.
- **Tối ưu hóa chi phí và hiệu năng:** Thực hiện lưu cache dữ liệu và nén tệp tin ngay tại biên để giảm tải lượng băng thông và chi phí cho server gốc (Origin).
- **Bảo mật và Độ tin cậy cao:** Tích hợp trực tiếp AWS WAF, AWS Shield chống tấn công DDoS tại Edge trước khi traffic đến hệ thống lõi.

#### 4. Trợ lý AI và Tự động hóa quy trình với Amazon Quick
- **Quick Chat Agent & Quick Flows:** Trợ lý ảo truy vấn dữ liệu thô và xây dựng quy trình tự động hóa thông minh (No-code workflows) hoàn toàn bằng ngôn ngữ tự nhiên.
- **Quick Spaces & Quick Sight:** Không gian làm việc cộng tác chia sẻ tri thức và xây dựng biểu đồ báo cáo (dashboards) tự động qua trò chuyện.

#### 5. Tính phi xác định (Non-Determinism) của LLM ở tầng sâu
- **Cơ chế chọn Token:** LLMs chọn từ tiếp theo dựa trên phân phối xác suất logits.
- **Giải mã lầm tưởng `Temperature = 0`:** Đặt nhiệt độ bằng 0 không đảm bảo 100% đầu ra giống hệt nhau ở các lần chạy. Các tối ưu hóa tính toán song song số thực dấu phẩy động (float) ở tầng phần cứng GPU có thể tạo ra sai khác nhỏ, bị tích lũy dần làm thay đổi kết quả cuối cùng đối với các câu hỏi phức tạp.

#### 6. Hệ thống Multi-Agent cấp doanh nghiệp và bài toán Credit Scoring
- **Sức mạnh Multi-Agent:** Chia nhỏ bài toán phức tạp cho các Agent chuyên biệt (Financial Collector, Risk Analyst, Decision Maker) thay vì dùng Single Agent.
- **Giao thức MCP (Model Context Protocol):** Cách chuẩn hóa kết nối từ LLM đến nguồn dữ liệu, chuyển đổi mô hình tích hợp phức tạp $M \times N$ thành $M + N$ tinh giản.

---

### Những Gì Học Được

#### Tư Duy Thiết Kế
- **Thiết kế Edge-First & Well-Architected:** Luôn đặt yếu tố tối ưu chi phí, bảo mật và tốc độ tại biên mạng làm nền tảng.
- **Tư duy Multi-Agent & Human-in-the-loop:** Thiết kế hệ thống AI phân vai chuyên biệt và giữ con người trong vai trò quản lý (Reviewer/Manager) phê duyệt trước khi hệ thống thực thi.
- **Chấp nhận tính phi xác định:** Thiết kế hệ thống ứng dụng AI luôn sẵn sàng xử lý các đầu ra biến đổi nhẹ của LLM thông qua các cơ chế kiểm thử chatbot tự động.

#### Kiến Trúc Kỹ Thuật
- Quy trình áp dụng giao thức MCP để đơn giản hóa cổng kết nối API dữ liệu doanh nghiệp với AI.
- Kỹ thuật thiết kế prompt nâng cao (Context Engineering) kết hợp bộ nhớ ngoài (Second AI Brain) để kiểm soát chất lượng phản hồi LLM.
- Các chiến lược giảm thiểu không đồng bộ trong LLM bằng cách sử dụng `Temperature = 0.1` để tránh lỗi lặp từ vô hạn của Greedy Decoding, và cấu hình `repeat_penalty` trên các mô hình tự host.

#### Bài học về Quy trình doanh nghiệp
- POC (Proof of Concept) thì rất dễ dàng, nhưng đưa lên Production là câu chuyện tuân thủ bảo mật khắt khe.
- **Sự nguy hiểm của "Copy-Paste Code" (Bài học xương máu):** Dùng AI viết code từ 0 đến 1 rất nhanh, nhưng từ 1 đến N đòi hỏi kỹ luật phần mềm cao. Tuyệt đối không copy-paste bừa bãi code AI sinh ra (`Ctrl+C` / `Ctrl+V`) mà không đọc hiểu kỹ, tránh gây sập (crash) hệ thống Production.

---

### Ứng Dụng Vào Công Việc & Học Tập

- **Triển khai Amazon CloudFront:** Thử nghiệm tích hợp CloudFront làm CDN phân phối tài nguyên cho ứng dụng web cá nhân/bài tập lớn để tối ưu hóa tốc độ tải trang.
- **Xây dựng hệ thống Multi-Agent đơn giản:** Thực hành dùng các framework như LangChain hoặc CrewAI để thiết lập luồng phối hợp giữa 2-3 Agent mô phỏng các nhiệm vụ tự động hóa nhỏ.
- **Áp dụng kỷ luật lập trình cùng AI:** Rèn luyện kỹ năng đọc hiểu và rà soát kỹ lưỡng mọi dòng code do AI gợi ý trước khi tích hợp vào dự án. Áp dụng kỹ thuật đặt cấu hình nhiệt độ thông minh (`Temperature = 0.1`) và viết các ca kiểm thử tự động cho chatbot.

---

### Trải nghiệm trong event

#### Học hỏi từ các diễn giả có chuyên môn cao
- Tiếp thu các case study thực tế từ anh Tín Trương về cách xây dựng nền tảng nội bộ và anh Đức Đào về kỹ thuật tối ưu hóa LLM.
- Nắm bắt được các phương pháp tối ưu hóa hạ tầng và tăng tốc ứng dụng tại vùng biên (Edge Computing) bằng Amazon CloudFront từ chuyên gia hạ tầng AWS.

#### Trải nghiệm kỹ thuật thực tế
- Hiểu được hành trình phát triển kịch tính 36 giờ của đội LotusHacks xây dựng sản phẩm UTMorpho dưới áp lực thời gian, rút ra kinh nghiệm quý báu về xây dựng sản phẩm MVP và tinh thần đồng đội.
- Trực tiếp quan sát các bản demo trực quan của Amazon Quick và kiến trúc Hội đồng Tín dụng Ảo (Virtual Credit Committee).

#### Kết nối và trao đổi
- Có cơ hội trò chuyện với các bạn sinh viên và kỹ sư từ nhiều trường đại học và doanh nghiệp công nghệ tại TP. HCM.

#### Bài học rút ra
- Sự phát triển vũ bão của AI (năng lực gấp đôi mỗi 4 tháng) đòi hỏi tinh thần chủ động học hỏi liên tục và không trì hoãn.
- Sự kết hợp hoàn hảo giữa nền tảng kiến thức kỹ thuật trường lớp vững chắc, khả năng làm chủ AI thông minh và sự hiểu biết về nghiệp vụ doanh nghiệp (domain knowledge) sẽ là chìa khóa mở ra cánh cửa cơ hội nghề nghiệp trong tương lai.

---

#### Một số hình ảnh khi tham gia sự kiện

![Event Picture 1](/fcaj-report/images/event/event 2/event2-1.jpg?v=20260710)
![Event Picture 2](/fcaj-report/images/event/event 2/event2-2.jpg?v=20260710)
![Event Picture 3](/fcaj-report/images/event/event 2/event2-3.jpg?v=20260710)
> **Tổng kết:** AWS Community Day Vietnam 2026 mang lại một trải nghiệm tuyệt vời, không chỉ bồi đắp kiến thức công nghệ Cloud & AI chuyên sâu mà còn khơi dậy tư duy kỹ sư chuyên nghiệp, tính kỷ luật trong lập trình và định hướng nghề nghiệp rõ ràng cho bản thân em.
