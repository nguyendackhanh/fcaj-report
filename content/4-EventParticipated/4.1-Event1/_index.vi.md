---
title: "Event 1: FCAJ Community Day 2026"
date: 2026-05-09
weight: 1
chapter: false
pre: " <b> 4.1. </b> "
---

### Mục Đích Của Sự Kiện

- **Cải thiện phương pháp học tập:** Hướng dẫn cách "hack não" để duy trì động lực học tập, biến việc học trở nên thú vị như chơi game.
- **Nâng cao kỹ năng sử dụng AI:** Chia sẻ các phương pháp Prompt Engineering tối ưu để tương tác hiệu quả với LLM, tránh tình trạng "ảo giác" (hallucination) của AI.
- **Định hướng nghề nghiệp thực tế:** Cung cấp góc nhìn từ nhà tuyển dụng về việc đánh giá ứng viên, tầm quan trọng của nền tảng (foundation) và sự liêm chính (integrity) trong công việc, đặc biệt trong thời đại AI.

---

### Nội Dung Nổi Bật

#### 1. Hack não để "nghiện" học (Dopamine Driven Learning) - *Diễn giả: Anh Huỳnh Hoàng Long*
- **Vấn đề:** Mạng xã hội và game tạo ra phần thưởng nhanh (instant gratification) và sự tò mò, khiến não bộ tiết dopamine liên tục. Trong khi đó, việc học thường mang lại kết quả chậm.
- **Giải pháp:** 
  - Đánh lừa não bộ bằng cách tự tạo ra các phần thưởng nhỏ và ngẫu nhiên sau mỗi phiên học (ví dụ: bốc thăm phần thưởng sau 10 phút học).
  - Sử dụng **nỗi sợ mất mát**: Tạo chuỗi (streak) học tập mỗi ngày trên lịch, vì con người sợ mất đi những gì đã tích lũy (như mất chuỗi check-in).
  - **Quy tắc 2 phút:** Việc gì làm được trong 2 phút thì làm ngay, không trì hoãn.
  - Chia nhỏ mục tiêu để tránh cảm giác ngợp (ví dụ: học từng dịch vụ AWS nhỏ mỗi ngày thay vì học dồn 5 tiếng).

#### 2. Ultimate Prompt Engineering: Nâng cao chất lượng đầu ra của LLM - *Diễn giả: Anh Nguyễn Tuấn Thịnh*
- **Kỹ năng thiết kế Prompt:** Để AI trả lời tốt, cần cung cấp đủ 7 thành phần: Role (Vai trò), Instruction (Chỉ thị), Context (Ngữ cảnh), Input (Đầu vào), Output format (Định dạng đầu ra), Examples (Ví dụ) và Constraints (Ràng buộc).
- **Các kỹ thuật nâng cao:** Sử dụng *Chain of Thought* (Tư duy từng bước) hoặc *Tree of Thought*. Tránh sử dụng ngôn ngữ cấm đoán ("do not") để giảm thiểu AI hallucination.
- **Demo Thực tiễn - Proptimizer:** Một ứng dụng trên AWS giúp tối ưu hóa prompt. Kiến trúc ứng dụng sử dụng:
  - **Frontend:** S3 & CloudFront (CDN).
  - **Auth:** Amazon Cognito.
  - **Backend (Serverless):** API Gateway & AWS Lambda.
  - **Database & AI:** DynamoDB lưu lịch sử và Amazon Bedrock cung cấp các mô hình AI Foundation.

#### 3. Tại sao các bạn chưa đi làm? - Góc nhìn từ Nhà Tuyển Dụng - *Diễn giả: Anh Nguyễn Khang (Solutions Architect tại Cloud Kinetics)*
- **Tư duy nền tảng (Foundation):** Công nghệ thay đổi liên tục, không cần phải biết tất cả mọi framework hay service. Quan trọng nhất là nền tảng vững chắc và khả năng tư duy giải quyết vấn đề (thought process).
- **AI là bộ khuếch đại (Amplifier):** AI sẽ làm người giỏi giỏi hơn và người tệ đi xuống. Nếu bạn dùng AI để làm bài nhưng không thực sự hiểu "Tại sao" (Why), nhà tuyển dụng sẽ nhận ra ngay. Sự hiểu biết không thể outsource cho AI.
- **5 Tiêu chí Tuyển dụng Fresher:**
  1. Thái độ (Quan trọng nhất đối với Fresher).
  2. Trình độ/ Học vấn.
  3. Kỹ năng.
  4. Kinh nghiệm và Trải nghiệm (Kinh nghiệm có thể ít, nhưng trải nghiệm qua các dự án đa dạng là điểm cộng lớn).
  5. Tố chất (Bản năng và khả năng tự nhiên).
- **Sự liêm chính (Integrity):** Luôn làm đúng, làm tới cùng ngay cả khi không có ai giám sát. Cần có tầm nhìn dài hạn và không nên làm việc một mình.

#### 4. Phát triển phần mềm tự động với AI Agent (Phương pháp BMX) - *Diễn giả: Chị Thảo (Software Developer tại VIB)*
- **Thực trạng lập trình với AI:** Trò chuyện trực tiếp với AI (như ChatGPT) mà không có kiến trúc hệ thống rõ ràng thường dẫn đến code rác (spaghetti code), AI quên ngữ cảnh (hallucination) và khó bảo trì.
- **Phương pháp BMX (BMX Method):** Giải pháp mã nguồn mở phân chia công việc thành các tác vụ nhỏ chuẩn Software Development Life Cycle (SDLC).
- **Hệ sinh thái Multi-Agent:**
  - **PM Agent:** Phân tích ý tưởng và tự động sinh ra các tài liệu yêu cầu dự án (PRD).
  - **Architect Agent:** Dựa trên PRD để thiết kế hệ thống (System Architecture) chọn công nghệ phù hợp.
  - **Scrum Master Agent / BO Agent:** Chia nhỏ yêu cầu lớn (Epic) thành các Story và quản lý luồng trạng thái (Draft -> Approve -> Block -> Review).
  - **Developer Agent:** Tự động bắt lấy các story đã approve, viết code và đổi trạng thái.
  - **QA/Review Agent:** Tự động kiểm tra code, lặp lại vòng feedback liên tục cho đến khi số lượng bug bằng 0.
- **Ưu điểm:** Giảm bớt lượng context window cho mỗi agent, AI không bị nhiễu thông tin, dễ dàng mở rộng và can thiệp thủ công (human-in-the-loop).

---
#### Một số hình ảnh khi tham gia sự kiện
![Event Picture 1](/fcaj-report/images/event/event 1/event1-1.jpg?v=20260710)
![Event Picture 2](/fcaj-report/images/event/event 1/event1-2.jpg?v=20260710)
![Event Picture 3](/fcaj-report/images/event/event 1/event1-3.jpg?v=20260710)

### Những Gì Học Được
- Hiểu được cơ chế hoạt động của Dopamine để tự tạo động lực học tập AWS mỗi ngày mà không bị chán nản.
- Biết cách tối ưu hóa câu lệnh (Prompt) khi sử dụng AI, cũng như hình dung được một kiến trúc Serverless thực tế kết hợp AI trên AWS (S3, API Gateway, Lambda, Bedrock).
- Nhận ra tầm quan trọng của việc hiểu sâu bản chất vấn đề (hỏi "Why" nhiều lần) thay vì chỉ học vẹt công cụ. Thái độ và sự liêm chính là chìa khóa để tiến xa trong nghề nghiệp.
