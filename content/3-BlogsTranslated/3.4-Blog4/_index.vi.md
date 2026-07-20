---
title: "Blog 4: Bức tranh toàn cảnh: Giám sát thống nhất cho AWS Parallel Computing Service"
date: 2026-06-02
weight: 4
chapter: false
pre: " <b> 3.4. </b> "
---


*bởi Ronald Hudson và Nate Haynes*
*vào ngày 02 Tháng 6, 2026*

Điện toán hiệu năng cao (HPC) trên AWS đòi hỏi khả năng giám sát chính xác, giống như công nghệ đo từ xa mà các đội đua Công thức 1 sử dụng để mang lại kết quả tối ưu. Tương tự như việc các kỹ sư đường đua theo dõi hiệu suất xe, các quản trị viên AWS Parallel Computing Service (AWS PCS) phải giám sát các số liệu điện toán trong thời gian thực. Sự cảnh giác này rất quan trọng vì hiệu suất bị suy giảm trong các tính toán dài hạn — vốn thường kéo dài nhiều ngày hoặc nhiều tuần — có thể làm ảnh hưởng đến độ chính xác của nghiên cứu và làm tăng chi phí điện toán.

AWS PCS cho phép các tổ chức chạy khối lượng công việc điện toán song song khổng lồ trên đám mây. Dịch vụ này hỗ trợ hàng nghìn công việc (jobs) đồng thời và tự động mở rộng tài nguyên để đáp ứng nhu cầu, giúp loại bỏ các khoản đầu tư cơ sở hạ tầng trả trước. Khả năng này biến đổi các ứng dụng HPC trên khắp các ngành công nghiệp: các phòng thí nghiệm nghiên cứu giờ đây hoàn thành giải trình tự bộ gen trong vài giờ thay vì vài tuần, các công ty kỹ thuật chạy các mô phỏng phức tạp nhanh hơn 10 lần và các tổ chức tài chính xử lý các mô hình rủi ro theo thời gian thực. AWS PCS làm cho điện toán tiên tiến có thể tiếp cận được với các tổ chức bất kể quy mô, thúc đẩy đổi mới trong nghiên cứu khoa học, mô hình hóa tài chính và học máy (machine learning).

Chúng tôi vui mừng thông báo về giải pháp giám sát (observability solution) mới cho khách hàng AWS PCS. Giải pháp này sẽ cung cấp:
- Khả năng hiển thị chi tiết về môi trường HPC của bạn.
- Cung cấp thông tin chuyên sâu, rõ ràng về phân bổ và mức tiêu thụ tài nguyên.
- Theo dõi hiệu suất công việc theo thời gian thực.
- Truy cập nhanh hơn vào dữ liệu chẩn đoán.

Với những khả năng này, người dùng có thể nhanh chóng xác định và giải quyết các sự cố tiềm ẩn trong môi trường HPC của họ, cải thiện khả năng quản lý và hiệu quả chung của hệ thống.

## Khả năng giám sát với Amazon Managed Grafana

Giải pháp này sử dụng Amazon Managed Grafana và Amazon Managed Service for Prometheus để thu thập và trình bày một tập hợp các bảng điều khiển (dashboards) cho người dùng. Giải pháp thu thập dữ liệu từ Amazon CloudWatch Logs, Slurm Exporter, EFA Exporter, Node Exporter và DCGM (Data Center GPU Manager) Exporter. Sơ đồ sau đây minh họa toàn bộ kiến trúc tổng thể.

![Hình 1 – Kiến trúc giải pháp giám sát.](https://d2908q01vomqb2.cloudfront.net/e6c3dd630428fd54834172b8fd2735fed9416da4/2026/05/28/PCS-Observability-Architecture.jpg)
*Hình 1 – Kiến trúc giải pháp giám sát.*

Giải pháp sử dụng AWS Distro for OpenTelemetry Collector để lấy dữ liệu từ các Exporter (Slurm, EFA, Node, DCGM). Dữ liệu này được gửi tới Amazon Managed Service for Prometheus, sau đó được hiển thị trong Amazon Managed Grafana. Amazon Managed Grafana cũng lấy dữ liệu từ Amazon CloudWatch Logs để cung cấp thông tin chi tiết về các phiên bản máy chủ.

Bảng điều khiển ban đầu cung cấp cho người dùng một cái nhìn tổng quan về cụm (cluster) của họ với một số thông tin cơ bản (Hình 2). Bảng điều khiển này cung cấp thông tin về tổng số CPU khả dụng, đã phân bổ, nhàn rỗi hoặc trong các trạng thái Slurm job khác.

![Hình 2. Bảng điều khiển tóm tắt trạng thái cụm.](https://d2908q01vomqb2.cloudfront.net/e6c3dd630428fd54834172b8fd2735fed9416da4/2026/05/28/image003-1.png)
*Hình 2. Bảng điều khiển tóm tắt trạng thái cụm.*

Sử dụng Danh sách Bảng điều khiển ở góc trên bên phải, người dùng có thể điều hướng đến các bảng bổ sung cung cấp thông tin chi tiết về Jobs, Nodes, GPUs, Slurm, Amazon FSx for Lustre, Logs, Partitions và Elastic Fabric Adapter (EFA).

Bảng điều khiển công việc (Jobs Dashboard - Hình 3) cung cấp thông tin chuyên sâu về các công việc đang chạy trong cụm. Người dùng có thể xem chi tiết về các phiên bản đang chạy cùng với số liệu về mức sử dụng CPU, bộ nhớ và đĩa.

![Hình 3. Bảng điều khiển tóm tắt trạng thái công việc và sử dụng tài nguyên cụm.](https://d2908q01vomqb2.cloudfront.net/e6c3dd630428fd54834172b8fd2735fed9416da4/2026/05/28/image004-2.jpg)
*Hình 3. Bảng điều khiển tóm tắt trạng thái công việc và sử dụng tài nguyên cụm.*

Bảng điều khiển NVIDIA GPU (Hình 4) cung cấp thông tin chuyên sâu về các NVIDIA GPU trong cụm. Người dùng có thể xem các chỉ số, chẳng hạn như tải GPU và bộ nhớ đã tiêu thụ.

![Hình 4. Bảng điều khiển tóm tắt việc sử dụng NVIDIA GPU trong cụm.](https://d2908q01vomqb2.cloudfront.net/e6c3dd630428fd54834172b8fd2735fed9416da4/2026/05/28/image005.jpg)
*Hình 4. Bảng điều khiển tóm tắt việc sử dụng NVIDIA GPU trong cụm.*

Bảng điều khiển Nhật ký (Logs Dashboard - Hình 5) cung cấp chế độ xem có thể tìm kiếm đối với các nhật ký khác nhau liên quan đến cụm. Nó báo cáo các sự kiện nhật ký và dòng thời gian khi các sự kiện này xảy ra.

![Hình 5. Bảng điều khiển tóm tắt các nhật ký khác nhau liên quan đến cụm.](https://d2908q01vomqb2.cloudfront.net/e6c3dd630428fd54834172b8fd2735fed9416da4/2026/05/28/image006-1.png)
*Hình 5. Bảng điều khiển tóm tắt các nhật ký khác nhau liên quan đến cụm.*

Bảng điều khiển Phân vùng (Partitions Dashboard - Hình 6) cung cấp thông tin chi tiết về các phân vùng Slurm. Người dùng có thể chọn một phân vùng cụm thể và xem chi tiết, chẳng hạn như số máy được phân bổ, lịch sử công việc và công việc đang chờ.

![Hình 6. Bảng điều khiển tóm tắt phân vùng Slurm.](https://d2908q01vomqb2.cloudfront.net/e6c3dd630428fd54834172b8fd2735fed9416da4/2026/05/28/image007-1.jpg)
*Hình 6. Bảng điều khiển tóm tắt phân vùng Slurm.*

Một trong những bảng điều khiển được yêu cầu nhiều nhất là EFA. Bảng này hiển thị những node nào đang chạy EFA và cung cấp thông tin hiệu suất cho người dùng để xác minh cấu hình và hiệu suất của họ. Bảng điều khiển EFA (Hình 7) cung cấp thông tin chi tiết về các số liệu EFA, bao gồm thông tin thiết bị, lưu lượng được xử lý, số lượt đọc/ghi RDMA và gói dữ liệu bị mất (dropped packets).

![Hình 7. Bảng điều khiển tóm tắt số liệu EFA.](https://d2908q01vomqb2.cloudfront.net/e6c3dd630428fd54834172b8fd2735fed9416da4/2026/05/28/image008-3.jpg)
*Hình 7. Bảng điều khiển tóm tắt số liệu EFA.*

## Kết luận

Giải pháp giám sát cho AWS Parallel Computing Service đại diện cho một bước tiến đáng kể trong khả năng giám sát HPC. Bằng cách kết hợp Amazon Managed Grafana với Amazon Managed Service for Prometheus, khuôn khổ giám sát này cung cấp khả năng quan sát theo thời gian thực mà các quản trị viên HPC cần để tối ưu hóa môi trường điện toán của họ.

Các lợi ích chính của giải pháp này bao gồm:
- Giảm thời gian giải quyết các vấn đề hiệu suất thông qua giám sát tập trung.
- Cải thiện mức độ sử dụng tài nguyên với khả năng hiển thị chi tiết vào hiệu suất tính toán, lưu trữ và mạng.
- Nâng cao hiệu quả hoạt động thông qua việc thu thập dữ liệu tự động và trực quan hóa trực quan.
- Tối ưu hóa chi phí bằng cách xác định các tài nguyên chưa được sử dụng đúng mức và các điểm nghẽn hiệu suất.

Khi khối lượng công việc HPC tiếp tục phát triển về độ phức tạp và quy mô, việc có khả năng quan sát toàn diện ngày càng trở nên quan trọng. Giải pháp giám sát này trao quyền cho các tổ chức để tối đa hóa các khoản đầu tư AWS Parallel Computing Service của họ trong khi vẫn duy trì các tiêu chuẩn hiệu suất mà nghiên cứu và tính toán hiện đại yêu cầu.

Để bắt đầu, bạn có thể tải xuống giải pháp giám sát cho môi trường AWS Parallel Computing Service của mình tại liên kết sau:
https://github.com/aws-samples/aws-hpc-recipes/tree/main/recipes/pcs/observability_for_pcs
