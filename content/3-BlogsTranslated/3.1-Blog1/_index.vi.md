---
title: "Blog 1: Cách Bedrock Streaming tối ưu hóa chi phí AWS"
date: 2026-06-02
weight: 1
chapter: false
pre: " <b> 3.1. </b> "
---


*bởi Pascal Martin, Iryna Oliinykova, và Ramzi Trabelsi*
*vào ngày 02 Tháng 6, 2026*

## Giới thiệu

Tối ưu hóa chi phí là một thách thức lớn đối với các công ty phát video trực tuyến. Thách thức này càng gia tăng khi lưu lượng truy cập liên tục tăng và độ phức tạp của các giải pháp ngày càng lớn. Với chiến lược hoạt động tài chính đám mây (FinOps) có hệ thống, các tổ chức có thể biến mỗi quyết định kỹ thuật thành một cơ hội tối ưu hóa chi phí, đạt được những khoản tiết kiệm đáng kể.

Bedrock Streaming là một ví dụ hoàn hảo cho phương pháp tiếp cận này. Công ty lưu trữ các giải pháp của họ trên Amazon Web Services (AWS) để phục vụ các đài truyền hình lớn của Châu Âu như M6+, Videoland và RTL+. Với ngân sách AWS lên tới vài triệu đô la mỗi năm, mỗi điểm phần trăm tối ưu hóa đều mang lại khoản tiết kiệm đáng kể. Việc quản lý chi phí đặc biệt khó khăn vì lưu lượng truy cập web của họ biến đổi trong suốt cả ngày, với các đỉnh điểm trong các sự kiện thể thao và các chương trình truyền hình nổi tiếng.

Kể từ khi bắt đầu di chuyển lên AWS vào năm 2018, Bedrock Streaming đã phát triển một phương pháp vượt xa các chiến lược đặt trước truyền thống. Công ty áp dụng chiến lược FinOps đa trục liên quan đến các node Kubernetes worker chạy 100% trên Amazon Elastic Compute Cloud (Amazon EC2) Spot Instances, AWS Graviton Processors, việc hợp lý hóa các lệnh gọi AWS API, tối ưu hóa phát video trực tuyến và liên tục chú ý đến lưu trữ dữ liệu. Phương pháp FinOps này biến mọi quyết định kỹ thuật thành đòn bẩy tối ưu hóa chi phí đám mây.

## Tối ưu hóa tính toán và các dịch vụ được quản lý

Bedrock Streaming tối ưu hóa chi phí điện toán AWS của mình bằng hai chiến lược chính. Đầu tiên, công ty triển khai đặt trước phiên bản (instance reservations) cho các dịch vụ được quản lý như Amazon Relational Database Service (Amazon RDS), Amazon ElastiCache, và Amazon OpenSearch Service, cũng như đặt trước dung lượng cho Amazon DynamoDB. Savings Plans chiếm chưa đến 5% mức sử dụng Amazon EC2, đồng thời cũng bao phủ các dịch vụ AWS Lambda và AWS Fargate.

Chiến lược thứ hai nhắm mục tiêu cụ thể vào Amazon EC2, nơi các Spot Instances thay thế các đặt phòng truyền thống. Phương pháp này đáp ứng nhu cầu tự động mở rộng quy mô (autoscaling) của Bedrock Streaming, nơi lưu lượng truy cập dao động theo hệ số 10 giữa các điểm thấp vào buổi sáng và đỉnh điểm vào buổi tối. Cơ sở hạ tầng sản xuất, bao gồm các node Kubernetes worker, chạy trên Spot Instances với khả năng tự động chuyển đổi sang các on-demand instances trong các giai đoạn thiếu hụt spot capacity.

AWS có thể thu hồi Spot Instances bất kỳ lúc nào với thông báo trước 2 phút. Bedrock Streaming đã triển khai termination handler, trình xử lý này sẽ được kích hoạt khi một phiên bản báo hiệu rằng nó sẽ bị thu hồi. Trình xử lý ngay lập tức khởi động một phiên bản mới trong khi dừng các ứng dụng được triển khai trên node cũ.

Nhóm đã giảm thời gian khởi động của các instance mới nhờ các Amazon Machine Images (AMIs) tùy chỉnh, kết hợp các thành phần Kubernetes và Docker images cơ sở mà ứng dụng của họ yêu cầu. Họ sử dụng hơn 10 loại phiên bản trong mỗi ba Availability Zones để tối đa hóa tính khả dụng. Phương pháp này có nghĩa là Bedrock Streaming có thể đạt được 100% Spot Instances cho Kubernetes.

Đối với các dịch vụ được quản lý như Amazon RDS, Amazon ElastiCache hoặc Amazon OpenSearch Service, nơi tính đàn hồi không đáp ứng được nhu cầu của Bedrock Streaming, các nhóm bắt đầu bằng việc triển khai các dự án mới của họ với các phiên bản có kích thước quá lớn, phân tích hành vi của chúng dưới tải thực tế trong vài ngày, sau đó thay đổi kích thước thành kích thước tối ưu. Chi phí bổ sung là không đáng kể và phương pháp này nhanh chóng mang lại chi phí tối ưu đồng thời tránh được rủi ro định cỡ thấp (undersizing). Nhóm sẽ thực hiện đặt trước (reservations) sau đó trong các đợt đánh giá đặt trước toàn cầu nửa năm một lần.

Việc áp dụng AWS Graviton Processors là một trụ cột tối ưu hóa hiệu quả khác. Các nhóm bắt đầu bằng việc di chuyển một số công việc Amazon Elastic MapReduce (Amazon EMR). Các khoản tiết kiệm lớn nhất đến trong quá trình di chuyển các phiên bản Amazon RDS, Amazon ElastiCache và Amazon OpenSearch Service sang AWS Graviton: Họ đã đạt được mức tiết kiệm 15%–20% bằng một thay đổi cấu hình nhanh chóng. Bước cuối cùng, đang được tiến hành, liên quan đến việc di dời số ít Kubernetes node không phải là Spot Instance (các master node).

## Tối ưu hóa các dịch vụ dữ liệu và lưu trữ

Lưu trữ với Amazon Simple Storage Service (Amazon S3) tạo thành nền tảng cho cơ sở hạ tầng của Bedrock Streaming để lưu trữ thư viện video của họ. Công ty sử dụng các tính năng nâng cao của Amazon S3, bao gồm các storage classes khác nhau, các chính sách chuyển đổi tự động (automatic transition policies), Intelligent Tiering cho các bucket có mức sử dụng biến đổi, và tự động hóa quản lý vòng đời đối tượng.

Quản lý lưu trữ hiệu quả vượt xa Amazon S3 tại Bedrock Streaming. Lưu trữ đám mây đòi hỏi sự cảnh giác cao hơn đối với sự tích lũy tài nguyên, chẳng hạn như theo dõi nghiêm ngặt các AMIs lỗi thời và các snapshots không sử dụng.

Trải nghiệm của Bedrock Streaming với Amazon Elastic Container Registry (Amazon ECR) minh họa cho vấn đề này. Trong quá trình di chuyển sang AWS và Kubernetes, chi phí Amazon ECR của công ty tăng lên đáng kể do sự tích tụ của Docker images được tạo ra bởi các bản triển khai hàng ngày. Kích hoạt tính năng dọn dẹp tự động (automatic purge) cho các image cũ trong Amazon ECR có nghĩa là Bedrock Streaming có thể kiểm soát các chi phí này.

Amazon DynamoDB là một trong những giải pháp Bedrock Streaming chọn cho khối lượng công việc quan trọng của họ. Tối ưu hóa chi phí Amazon DynamoDB dựa trên hai trục chính: quản lý truy vấn và lưu trữ dữ liệu. Lưu trữ dữ liệu đại diện cho đòn bẩy chính trong kiểm soát chi phí.

Công ty nhận thấy rằng chi phí lưu trữ cho một số bảng cao hơn chi phí truy vấn. Để giải quyết vấn đề này, Bedrock Streaming sử dụng tính năng time to live (TTL) của Amazon DynamoDB, cho phép tự động hết hạn các dữ liệu lỗi thời. Phương pháp này không chỉ tối ưu hóa chi phí lưu trữ trực tiếp mà còn giảm chi phí liên quan đến sao lưu bảng.

Đối với các bảng Amazon DynamoDB có lượng dữ liệu hiếm khi được truy cập lớn, lưu trữ lớp Infrequent Access tiêu chuẩn đại diện cho một tùy chọn tối ưu hóa có liên quan. Lớp này trở nên đặc biệt thuận lợi khi chi phí lưu trữ của bảng vượt quá 50% chi phí liên quan đến các hoạt động đọc và ghi.

## Tối ưu hóa chi phí mạng

Tối ưu hóa chi phí mạng là trọng tâm chính tại Bedrock Streaming. Việc triển khai virtual private cloud (VPC) endpoints cho Amazon S3 và Amazon DynamoDB giúp loại bỏ chi phí truyền tải qua AWS Network Address Translation (NAT) Gateway. Điều này tạo ra khoản tiết kiệm đáng kể cho các dịch vụ có lưu lượng truy cập cao.

Công ty cũng tối ưu hóa chi phí chuyển dữ liệu giữa các Availability Zone thông qua các thay đổi kiến ​​trúc có mục tiêu. Giải pháp video-on-demand streaming là một ví dụ minh họa. Phiên bản đầu tiên, được triển khai trên ba Availability Zones, liên quan đến việc truyền dữ liệu video (video segments) giữa các zones. Kiến trúc mới áp dụng phương pháp một zone, trong đó mỗi yêu cầu được xử lý hoàn toàn trong Availability Zone đầu vào của nó, giúp loại bỏ hoàn toàn chi phí chuyển dữ liệu giữa các Availability Zones.

Kiến trúc mới này duy trì mức độ phục hồi tương tự như kiến trúc trước đó. Điểm khác biệt là chế độ hoạt động của nó: Thay vì xử lý các yêu cầu được phân phối trên ba Availability Zones, giải pháp xử lý mỗi yêu cầu hoàn toàn trong zone tiếp nhận của nó. Cách tiếp cận này loại bỏ chi phí truyền liên vùng Availability Zone trong khi vẫn bảo toàn tính sẵn sàng cao.

## Các khía cạnh ít được biết đến của tối ưu hóa chi phí

Khi quá trình triển khai AWS của họ tiến triển vào năm 2018–2019, Bedrock Streaming đã xác định được các chi phí ngoài dự kiến trên một số dự án. Một trường hợp quan trọng liên quan đến API để tải hình ảnh được lưu trữ trên S3, trong đó chi phí API vượt quá chi phí lưu trữ.

Phân tích mã cho thấy API đang kiểm tra sự tồn tại của mỗi cấp trong cấu trúc phân cấp đường dẫn tệp một cách không cần thiết, một hoạt động dư thừa trong môi trường S3. Nhóm đã thay thế các kiểm tra này bằng cách truy cập hình ảnh trực tiếp và thực hiện xử lý lỗi 404. Kết quả là nhóm đã đạt được ba lợi ích chính: chức năng được bảo tồn, giảm độ trễ và giảm chi phí API.

Việc sử dụng Amazon Simple Queue Service (Amazon SQS) tại Bedrock Streaming là một ví dụ quan trọng khác. Công ty đã áp dụng cách xử lý hàng loạt (batch) cho các tin nhắn thay vì xử lý riêng lẻ và đã giảm chi phí hoạt động xóa của họ đi 66%.

## Quản lý số liệu (Metrics) và Logs

Bedrock Streaming ưu tiên cách tiếp cận tập trung để theo dõi số liệu. Thay vì trực tiếp sử dụng bảng điều khiển Amazon CloudWatch, công ty sử dụng hệ thống xuất số liệu sang nền tảng Prometheus. Một Amazon CloudWatch exporter chuyên dụng thực hiện truy vấn định kỳ các API `GetMetricStatistics` và `GetMetricData`.

Ban đầu, trình xuất (exporter) được cấu hình để thu thập một lượng lớn các số liệu làm biện pháp phòng ngừa. Bedrock Streaming tối ưu hóa cấu hình bằng cách căn chỉnh chính xác các số liệu được thu thập với các số liệu được sử dụng trong Grafana. Sự hợp lý hóa này làm giảm chi phí gọi API đi hai lần rưỡi.

Quản lý log là một trục tối ưu hóa chi phí khác. Công ty áp dụng chiến lược kép là hợp lý hóa thông tin được thu thập và thực hiện chính sách lưu giữ (retention) phù hợp. Đối với các log yêu cầu lưu giữ lâu dài, đặc biệt vì mục đích tuân thủ, Amazon CloudWatch Logs Infrequent Access cho phép giảm tới 50% chi phí nhập (ingestion) và lưu trữ.

## Hiểu cách hoạt động của các dịch vụ AWS

Tối ưu hóa chi phí đòi hỏi phải hiểu sâu về các đặc thù của từng dịch vụ AWS, cả ở cấp độ chức năng và tài chính.

Ví dụ, AWS Step Functions được thiết lập ở chế độ Express (express mode) thay vì chế độ Standard mặc định, giúp giảm đáng kể tác động tài chính.

Tối ưu hóa chi phí Amazon DynamoDB tại Bedrock Streaming dựa trên việc lựa chọn cẩn thận capacity mode (chế độ dung lượng) cho từng bảng:
- **On-demand mode**: Thích hợp cho các bảng có lưu lượng thay đổi lớn và khó dự đoán.
- **Provisioned mode with autoscaling**: Hiệu quả hơn cho các bảng có mẫu lưu lượng có thể dự đoán được.

Việc lựa chọn giữa hai chế độ này được thực hiện dựa trên đặc điểm cụ thể của từng workload. Chế độ Provisioned mang lại lợi thế bổ sung khi cho phép đặt trước (capacity reservations), tạo điều kiện giảm chi phí bổ sung về lâu dài.

Bedrock Streaming tuân theo một phương pháp đã được chứng minh cho các dự án Amazon DynamoDB mới. Công ty bắt đầu một cách có hệ thống với On-demand mode để hỗ trợ tính ổn định và hiệu suất. Sau vài ngày quan sát và phân tích các dạng thức sử dụng, họ đánh giá các bảng về khả năng chuyển sang Provisioned mode.

## Phương pháp tiếp cận tối ưu hóa chi phí về mặt kỹ thuật và văn hóa

Tối ưu hóa chi phí AWS phải là một phần của sự suy ngẫm tổng thể về lợi tức đầu tư (ROI) cơ sở hạ tầng. Mục tiêu là đạt được sự cân bằng tối ưu giữa chi phí và việc đáp ứng nhu cầu hoạt động. Bedrock Streaming minh họa cách tiếp cận này bằng cách hạn chế sử dụng dòng T instance (burstable performance) trong sản xuất, ưu tiên sự ổn định về hiệu suất bất chấp chi phí cao hơn.

Bedrock Streaming sử dụng một chiến lược theo dõi và tối ưu hóa chi phí dựa trên ba công cụ bổ sung:
- **AWS Cost Explorer**: Phân tích chi tiêu chi tiết.
- **AWS Cost Anomaly Detection**: Phát hiện sự cố và gia tăng chi phí ngoài ý muốn bằng Machine Learning.
- **AWS Cost Optimization Hub**: Cung cấp góc nhìn tập trung về các cơ hội tối ưu hóa.

Mặc dù các nhóm cơ sở hạ tầng quản lý các công cụ như Reservations và Savings Plans, tối ưu hóa chi phí hiệu quả đòi hỏi sự tham gia rộng rãi hơn. Tất cả các nhóm và đơn vị kinh doanh cần nhận ra rằng quản lý chi phí hosting thuộc trách nhiệm của họ và không chỉ riêng của nhóm hạ tầng.

## Phần kết luận

Bằng cách kết hợp 100% Amazon EC2 Spot Instances với các Kubernetes worker node, sử dụng AWS Graviton Processors và tinh chỉnh các dịch vụ dữ liệu như Amazon DynamoDB, Bedrock Streaming đạt được mức tiết kiệm đáng kể cho ngân sách hàng triệu đô la của họ. Những kỹ thuật này vượt ra ngoài các phương pháp đặt trước (reservations) truyền thống.

Chiến lược tối ưu hóa trong lĩnh vực truyền phát video có thể chuyển nhượng sang nhiều ngành công nghiệp. Bất kể tải truy cập là bao nhiêu, bạn luôn có thể áp dụng các chiến lược tương tự như Bedrock Streaming. Hãy bắt đầu hành trình tối ưu hóa của riêng bạn với các công cụ AWS như AWS Cost Anomaly Detection ngay hôm nay. Như Bedrock Streaming đã chứng minh, mỗi điểm phần trăm tối ưu hóa đều có giá trị.
