---
title: "Blog 6: Xây dựng lớp tìm kiếm người dùng có thể mở rộng trên Amazon Cognito"
date: 2026-06-01
weight: 6
chapter: false
pre: " <b> 3.6. </b> "
---

*bởi Philip Chen và Varun Selvaraj*
*vào ngày 01 Tháng 6, 2026*

Hãy tưởng tượng một người đồng đội cần tìm kiếm một người dùng trên hàng ngàn tài khoản với chỉ một phần địa chỉ email, tên họ và cấp độ truy cập đã biết. Đội ngũ của bạn có thể phản hồi nhanh đến mức nào? Nếu trường hợp sử dụng của bạn chỉ bao gồm các tìm kiếm đơn giản về các thuộc tính tiêu chuẩn của Amazon Cognito, thì API `ListUsers` tích hợp sẵn có thể là tất cả những gì bạn cần. Nhưng đối với các kịch bản nâng cao liên quan đến các thuộc tính tùy chỉnh, khớp mờ (fuzzy matching), lọc phức tạp và thời gian phản hồi dưới giây, một lớp tìm kiếm chuyên dụng là khoản đầu tư đúng đắn.

Amazon Cognito cung cấp khả năng quản lý và xác thực người dùng mạnh mẽ cho các ứng dụng hiện đại. Khi các ứng dụng mở rộng, các nhóm phát triển thường triển khai chức năng tìm kiếm nâng cao để tìm người dùng bằng cách khớp một phần email, phân đoạn quyền thành viên nhóm hoặc kiểm tra trên nhiều thuộc tính tùy chỉnh.

Trong bài viết này, chúng tôi chỉ ra cách xây dựng lớp tìm kiếm người dùng toàn diện, có thể mở rộng trên Amazon Cognito bằng AWS Lambda, Amazon DynamoDB và Amazon OpenSearch Service.

## Tổng quan giải pháp

Giải pháp này mở rộng Amazon Cognito với khả năng tìm kiếm nâng cao bằng cách sử dụng AWS Lambda, Amazon DynamoDB và Amazon OpenSearch Serverless.

Các khả năng chính:
- **Nhiều kiểu tìm kiếm**: Khớp chính xác (exact match), khớp tiền tố (prefix match) và tìm kiếm mờ (fuzzy search).
- **Lọc phức tạp**: Truy vấn đồng thời qua email, điện thoại, các nhóm và ngày đăng ký.
- **Hiệu suất cao**: Thời gian phản hồi dưới giây ở mọi quy mô.
- **Tự động đồng bộ hóa**: Cập nhật theo thời gian thực khi người dùng xác thực hoặc cập nhật hồ sơ.
- **Dựa trên API**: API RESTful hỗ trợ phân trang (pagination).

Kiến trúc này sử dụng bộ kích hoạt Cognito Lambda (Lambda triggers) để thu thập dữ liệu người dùng trong quá trình xác thực, lưu trữ trong DynamoDB và lập chỉ mục trong OpenSearch Serverless thông qua DynamoDB Streams. Sơ đồ kiến trúc sau minh họa cách các thành phần này hoạt động cùng nhau.

![Hình 1: Kiến trúc giải pháp cho Người dùng Cognito có thể tìm kiếm](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/Screenshot-2026-05-22-at-10.19.09%E2%80%AFAM-1024x652.png)
*Hình 1: Kiến trúc giải pháp cho Người dùng Cognito có thể tìm kiếm*

## Hướng dẫn các bước

Kiến trúc giải pháp trình bày hai luồng: Luồng nhập liệu (Ingestion flow) và Luồng tìm kiếm (Search flow).

### Luồng nhập liệu

Luồng nhập liệu nắm bắt và lập chỉ mục dữ liệu người dùng thông qua hai con đường: Các bộ kích hoạt Cognito Lambda và AWS CloudTrail. Cùng với nhau, các con đường này duy trì đồng bộ hóa giữa chỉ mục tìm kiếm và Cognito mà không yêu cầu can thiệp thủ công hoặc lập lịch các công việc hàng loạt (batch jobs).

#### 1. Các bộ kích hoạt Cognito Lambda
Con đường này thu thập dữ liệu người dùng trong các sự kiện xác thực bằng cách sử dụng hàm kích hoạt Cognito Lambda xử lý hai loại kích hoạt: Xác nhận sau (Post-confirmation) và Tạo mã thông báo trước (Pre-token generation). Bộ kích hoạt Post-confirmation tạo hồ sơ người dùng ban đầu khi đăng ký, trong khi bộ kích hoạt Pre-token generation theo dõi hoạt động đăng nhập và thông tin client ứng dụng trên mỗi lần xác thực tiếp theo. Bộ kích hoạt Pre-token generation cũng cung cấp quyền truy cập vào thông tin thành viên nhóm của người dùng trong tải trọng sự kiện, được lập chỉ mục dưới dạng trường có thể tìm kiếm. Quy trình hoạt động qua các bước sau:
1. **Client khởi tạo đăng ký hoặc đăng nhập** — Người dùng gửi yêu cầu xác thực tới Amazon Cognito.
2. **Kích hoạt Post-confirmation** — Khi đăng ký, Cognito gọi Cognito trigger Lambda để tạo bản ghi người dùng ban đầu trong bảng DynamoDB với các thuộc tính hồ sơ (email, tên, nhóm).
3. **Kích hoạt Pre-token generation** — Tại mỗi lần đăng nhập, Cognito gọi Cognito trigger Lambda để cập nhật dấu thời gian đăng nhập và thông tin app client vào bảng DynamoDB.
4. **Xử lý Stream** — DynamoDB Streams phát hiện bản ghi mới hoặc được cập nhật và kích hoạt OSS ingest Lambda.
5. **Cập nhật Index** — OSS ingest Lambda xử lý sự kiện từ stream và lập chỉ mục dữ liệu người dùng trong OpenSearch Serverless.

Lưu ý: Các bộ kích hoạt Cognito Lambda được triển khai trong một VPC. Cognito thực thi thời gian chờ (timeout) 5 giây cho các chức năng kích hoạt. Nếu bạn đang mở rộng các bộ kích hoạt này bằng các chức năng bổ sung, hãy đảm bảo tổng thời gian thực hiện nằm trong giới hạn này. Xem xét thiết lập concurrency được cung cấp sẵn (provisioned concurrency) nếu các "cold starts" là một rào cản.

![Hình 2: Nhập dữ liệu người dùng qua các Bộ kích hoạt Cognito Lambda](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/Screenshot-2026-05-22-at-10.23.12%E2%80%AFAM-1024x646.png)
*Hình 2: Nhập dữ liệu người dùng qua các Bộ kích hoạt Cognito Lambda*

#### 2. CloudTrail
Con đường này nắm bắt các thay đổi của người dùng do quản trị viên khởi tạo xảy ra bên ngoài luồng xác thực, chẳng hạn như tạo người dùng bằng bảng điều khiển Cognito hoặc CLI. Những hành động này không kích hoạt các Lambda trigger của Cognito, vì vậy CloudTrail và EventBridge sẽ thu hẹp khoảng cách. Quy trình hoạt động qua các bước sau:
1. **Hành động quản trị viên được thực hiện** — Người dùng thực hiện hành động quản trị viên trong Amazon Cognito (ví dụ: tạo người dùng, cập nhật thuộc tính, thêm vào nhóm, vô hiệu hóa người dùng).
2. **Ghi lại lệnh gọi API** — AWS CloudTrail nắm bắt lệnh gọi API quản trị Cognito.
3. **Khớp quy tắc EventBridge** — Một quy tắc Amazon EventBridge khớp với sự kiện quản trị Cognito.
4. **Gọi CloudTrail event Lambda** — EventBridge gọi CloudTrail event consumption Lambda, nó đọc trạng thái người dùng hiện tại từ Cognito và nâng cấp/thêm hồ sơ vào bảng DynamoDB.
5. **Sự kiện thay đổi dòng** — DynamoDB Streams phát ra sự kiện thay đổi.
6. **Gọi OSS Lambda** — Sự kiện của stream kích hoạt OSS ingest Lambda.
7. **Lập chỉ mục dữ liệu người dùng** — OSS ingest Lambda lập chỉ mục dữ liệu người dùng đã được cập nhật vào OpenSearch Serverless.

![Hình 3: Nhập dữ liệu người dùng thông qua CloudTrail](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/Screenshot-2026-05-22-at-10.24.26%E2%80%AFAM-1024x360.png)
*Hình 3: Nhập dữ liệu người dùng thông qua CloudTrail*

![Hình 4: Mô hình dữ liệu cho các thuộc tính người dùng được lập chỉ mục trong Amazon DynamoDB](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/Screenshot-2026-05-22-at-10.26.45%E2%80%AFAM-1024x468.png)
*Hình 4: Mô hình dữ liệu cho các thuộc tính người dùng được lập chỉ mục trong Amazon DynamoDB*

### Luồng tìm kiếm

Với luồng tìm kiếm, những người dùng được ủy quyền có thể truy vấn thư mục người dùng đã lập chỉ mục:
1. **Gửi truy vấn** — Người dùng đã được xác thực gửi truy vấn tìm kiếm qua giao diện (UI).
2. **Xác thực yêu cầu** — API Gateway nhận yêu cầu có mã thông báo Cognito JWT và xác nhận bằng bộ ủy quyền (authorizer) của Cognito.
3. **Thực thi tìm kiếm** — Khi xác nhận thành công, hàm search Lambda được gọi với các tham số tìm kiếm.
4. **Truy vấn OpenSearch** — Lambda sẽ đảm nhận vai trò chỉ đọc (read-only) cho việc truy cập vào OpenSearch Service và thực hiện truy vấn với OpenSearch Serverless index.
5. **Trả kết quả** — Lambda định dạng và trả về kết quả truy vấn cho phần front-end, nơi giao diện hiển thị chúng theo định dạng phân trang.

![Hình 5: Biểu đồ trình tự luồng tìm kiếm](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/Screenshot-2026-05-22-at-10.27.49%E2%80%AFAM-1024x602.png)
*Hình 5: Biểu đồ trình tự luồng tìm kiếm*

![Hình 6: Tích hợp tìm kiếm người dùng trên giao diện Demo dựa trên nhiều thuộc tính](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/Screenshot-2026-05-22-at-10.28.40%E2%80%AFAM-1024x583.png)
*Hình 6: Tích hợp tìm kiếm người dùng trên giao diện Demo dựa trên nhiều thuộc tính*

![Hình 7: Tích hợp tìm kiếm người dùng trên giao diện Demo về tự động gợi ý](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/Screenshot-2026-05-22-at-10.29.35%E2%80%AFAM-1024x581.png)
*Hình 7: Tích hợp tìm kiếm người dùng trên giao diện Demo về tự động gợi ý*

## Trải nghiệm thử

Sẵn sàng để xem giải pháp này hoạt động? Kho lưu trữ bao gồm mọi thứ bạn cần để triển khai việc thực hiện công việc một cách hoàn chỉnh trong môi trường AWS của riêng bạn.

Mã nguồn cho giải pháp này có sẵn trên GitHub tại:
https://github.com/aws-samples/sample-user-search-layer-for-cognito

Kho chứa có tất cả mọi thứ bạn cần: mã hạ tầng AWS CDK, triển khai hàm Lambda, frontend React và tài liệu. Bạn có thể có một thư mục người dùng có thể tìm kiếm, hoạt động hoàn toàn trên tài khoản của bạn dưới 20 phút. Khi kiểm tra xong, hãy xóa mọi tài nguyên để tránh phát sinh chi phí tiếp theo.

## Kết luận

Trong bài viết này, bạn đã biết cách mở rộng Amazon Cognito với khả năng tìm kiếm nâng cao. Bằng cách kết hợp OpenSearch Serverless, DynamoDB Streams và các hàm Lambda, bạn có thể xây dựng kiến trúc hướng sự kiện, có thể mở rộng, tự động duy trì thư mục người dùng có thể tìm kiếm với hiệu suất truy vấn dưới một giây.

Mô hình này mở khóa các trường hợp sử dụng mạnh mẽ: nhóm hỗ trợ có thể nhanh chóng định vị người dùng trên hàng nghìn tài khoản, quản trị viên có thể phân đoạn người dùng theo nhóm để nhắm mục tiêu liên lạc và nhóm tuân thủ có thể kiểm tra các thuộc tính người dùng với bộ lọc phức tạp.
