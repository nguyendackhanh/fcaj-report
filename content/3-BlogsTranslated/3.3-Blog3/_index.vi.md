---
title: "Blog 3: Xây dựng cơ sở dữ liệu Oracle có tính sẵn sàng cao với Amazon FSx for NetApp ONTAP"
date: 2026-06-03
weight: 3
chapter: false
pre: " <b> 3.3. </b> "
---


*bởi Vignyanand Penumatcha và Sharath Lingareddy*
*vào ngày 03 Tháng 6, 2026*

Các cơ sở dữ liệu Oracle cung cấp năng lượng cho các ứng dụng doanh nghiệp cực kỳ quan trọng, khiến tính sẵn sàng liên tục của chúng trở nên thiết yếu đối với các hoạt động kinh doanh. Các giải pháp tính sẵn sàng cao (High Availability - HA) truyền thống của Oracle đòi hỏi phần mềm clustering phức tạp, mảng lưu trữ chia sẻ đắt tiền và các nhóm quản trị cơ sở dữ liệu chuyên biệt. Những phương pháp thông thường này thường đưa ra các điểm lỗi đơn lẻ (single points of failure) đồng thời đòi hỏi chi phí hoạt động đáng kể.

Các kiến trúc đám mây hiện đại cung cấp một phương pháp tiếp cận mang tính biến đổi, kết hợp Amazon FSx for NetApp ONTAP (FSxN) với các nhóm Amazon EC2 Auto Scaling, tự động tạo AMI, điều phối bằng AWS Lambda và AWS Systems Manager Parameter Store (SSM Parameter). Giải pháp này loại bỏ sự phức tạp của Oracle HA truyền thống đồng thời mang lại tính sẵn sàng cấp doanh nghiệp, khả năng phục hồi tự động và đảm bảo các phiên bản (instances) mới khởi chạy với cấu hình Oracle mới nhất.

Bài viết này chỉ ra cách xây dựng kiến trúc cơ sở dữ liệu Oracle có tính sẵn sàng cao bằng cách sử dụng lưu trữ chia sẻ FSxN, các nhóm Auto Scaling với cập nhật AMI động và điều phối serverless để giúp giảm thời gian phục hồi với các cấu hình hiện tại.

## Tổng quan giải pháp

Giải pháp sử dụng nhiều dịch vụ AWS hoạt động cùng nhau để tạo ra một kiến trúc tính sẵn sàng cao toàn diện. FSxN Multi-AZ cung cấp lưu trữ chia sẻ liên tục trải dài qua các Vùng Sẵn Sàng (Availability Zones) cho các tệp dữ liệu, phần mềm và cấu hình cơ sở dữ liệu Oracle, để dữ liệu vẫn có thể truy cập được khi các phiên bản EC2 được thay thế. Các nhóm Auto Scaling cung cấp khả năng quản lý vòng đời phiên bản tự động với các cấu hình AMI mới nhất, do đó, các phiên bản bị lỗi sẽ nhanh chóng được thay thế bằng các cấu hình giống hệt nhau, có thể truy cập ngay vào các tệp cơ sở dữ liệu Oracle hiện có trên FSxN. AWS Backup tạo các AMI nắm bắt các cấu hình máy chủ Oracle mới nhất bao gồm các bản vá và cài đặt, bảo toàn trạng thái máy chủ hoàn chỉnh để triển khai nhất quán. AWS Lambda trích xuất ID AMI từ các điểm khôi phục sao lưu và cập nhật Tham số SSM, điều phối toàn bộ quy trình quản lý cấu hình. Systems Manager Parameter Store lưu trữ ID AMI hiện tại cho các mẫu khởi chạy của nhóm Auto Scaling, vì vậy các phiên bản mới luôn khởi chạy với cấu hình gần nhất và có thể kết nối ngay lập tức với cơ sở dữ liệu Oracle trên bộ nhớ dùng chung.

Sơ đồ sau đây hiển thị kiến trúc hoàn chỉnh với tất cả các dịch vụ AWS và tương tác của chúng:

![Sơ đồ kiến trúc AWS](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/archblog-1212-image-1.png)

Các lợi ích chính bao gồm:
- **Recovery Time Objective (RTO)**: Có thể giúp đạt được RTO 2–5 phút với cấu hình Oracle mới nhất.
- **Recovery Point Objective (RPO)**: Gần như bằng không thông qua sao chép Multi-AZ đồng bộ.
- **Tính nhất quán của cấu hình**: Các phiên bản mới khởi chạy với thiết lập máy chủ Oracle giống hệt nhau.
- **Quản lý AMI tự động**: Tạo AMI theo lịch trình với các bản cập nhật Parameter Store.

## Hướng dẫn các bước

Hướng dẫn này minh họa việc triển khai Oracle HA bằng cách sử dụng bộ lưu trữ chia sẻ Amazon FSx for NetApp ONTAP, tạo AMI do AWS Backup điều khiển, điều phối Lambda và các nhóm Auto Scaling tích hợp Parameter Store để đảm bảo tính nhất quán của cấu hình và chuyển đổi dự phòng tự động.

### Điều kiện tiên quyết

Đối với hướng dẫn này, bạn nên có các điều kiện tiên quyết sau:
- Tài khoản AWS với các quyền thích hợp cho Amazon FSx, Auto Scaling, EC2, Lambda và Systems Manager.
- Một VPC với các mạng con (subnets) ở ít nhất hai Vùng Sẵn Sàng.
- Phần mềm cơ sở dữ liệu Oracle (Khách hàng chịu trách nhiệm tuân thủ giấy phép Oracle của riêng họ).
- Một phiên bản EC2 với cơ sở dữ liệu Oracle đã được cài đặt và cấu hình.
- Các vai trò AWS Identity and Access Management (IAM) để tạo AMI và giao tiếp giữa các dịch vụ.
- Kiến thức cơ bản về quản trị cơ sở dữ liệu Oracle và tự động hóa AWS.

### Giả định

Bài đăng này là một minh họa khái niệm về kiến trúc. Quá trình triển khai cụ thể của bạn sẽ khác nhau dựa trên cấu hình VPC, phiên bản Oracle, yêu cầu lưu trữ và chính sách bảo mật của tổ chức.

Chúng tôi giả định rằng người đọc đã quen thuộc với:
- Tạo và cấu hình hệ thống tệp Amazon FSx for NetApp ONTAP thông qua bảng điều khiển AWS.
- Các khái niệm iSCSI bao gồm initiators, targets, và multipath I/O.
- Các quy trình khởi động và tắt cơ sở dữ liệu Oracle.
- Các nguyên tắc cơ bản của AWS Backup, Lambda và Auto Scaling group.

### Bước 1: Tạo hệ thống tệp Amazon FSx for NetApp ONTAP

FSxN Multi-AZ cung cấp nền tảng lưu trữ chia sẻ liên tục cho kiến trúc này. Không giống như khối lượng Amazon Elastic Block Store (Amazon EBS) bị ràng buộc với một AZ duy nhất, FSxN Multi-AZ sao chép dữ liệu đồng bộ qua hai AZ với khả năng chuyển đổi dự phòng tự động. Điều này có nghĩa là khi một phiên bản EC2 được thay thế, phiên bản mới có thể truy cập ngay vào các tệp cơ sở dữ liệu Oracle hiện có mà không cần khôi phục từ bản sao lưu.

Để tạo hệ thống tệp, hãy điều hướng đến bảng điều khiển Amazon FSx và chọn Amazon FSx for NetApp ONTAP làm loại hệ thống tệp. Lựa chọn cấu hình quan trọng là chọn triển khai Multi-AZ, trong đó sẽ đặt một máy chủ tệp hoạt động ở một AZ và một máy chủ dự phòng ở AZ khác.

![Bảng điều khiển Amazon FSx](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/archblog-1212-image-2.png)
*Bảng điều khiển FSxN hiển thị lựa chọn loại triển khai Multi-AZ.*

Sau khi hệ thống tệp được tạo, bạn cần thiết lập Storage Virtual Machine (SVM), hoạt động như một thùng chứa lưu trữ logic cung cấp quyền truy cập dữ liệu cho các phiên bản Oracle của bạn. Khi có SVM, bước tiếp theo là cấu hình quyền truy cập iSCSI thông qua các địa chỉ IP endpoint.

![Amazon FSx Storage Virtual Machine](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/archblog-1212-image-3.png)
*Tab Endpoints của SVM hiển thị các địa chỉ IP iSCSI endpoint cho mỗi vùng sẵn sàng.*

Thiết lập iSCSI bao gồm việc tạo iGroups và LUN thông qua CLI của NetApp ONTAP. Ở phía EC2, bạn cấu hình iSCSI initiator để khám phá và kết nối với các endpoint FSxN, sau đó gắn (mount) các khối lượng thiết bị.

Bạn cũng cần cấu hình nhóm bảo mật cho truy cập FSxN, bao gồm các cổng như 111, 635, 2049 (NFS), 3260 (iSCSI), v.v.

### Bước 2: Thiết lập AWS Backup để bảo vệ phiên bản EC2

AWS Backup nắm bắt trạng thái hoàn chỉnh của phiên bản EC2 Oracle. Lựa chọn thiết kế quan trọng là sử dụng lựa chọn tài nguyên dựa trên thẻ (tag) thay vì chỉ định trực tiếp ID phiên bản. Điều này đảm bảo mọi phiên bản mới do Auto Scaling thay thế đều được sao lưu.

![Bảng điều khiển AWS Backup](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/archblog-1212-image-4.png)
*Phân bổ tài nguyên AWS Backup được cấu hình với lựa chọn dựa trên thẻ (tag).*

### Bước 3: Cấu hình Lambda để quản lý AMI

Khi AWS Backup hoàn tất sao lưu EC2, nó tạo ra một AMI dưới dạng điểm khôi phục. Quy tắc Amazon EventBridge sẽ phát hiện sự kiện hoàn thành này và kích hoạt một hàm Lambda. Hàm này lấy ra AMI ID và cập nhật vào SSM Parameter Store, đồng thời dọn dẹp các AMI cũ.

![Hàm AWS Lambda](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/archblog-1212-image-5.png)
*Tổng quan về hàm Lambda.*

Quy trình tiếp cận dựa trên sự kiện này có nghĩa là AMI mới nhất luôn có sẵn mà không cần can thiệp thủ công.

![Quy tắc Amazon EventBridge](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/archblog-1212-image-6.png)
*Quy tắc EventBridge cấu hình để khớp với sự kiện hoàn thành tác vụ của AWS Backup.*

### Bước 4: Cấu hình Systems Manager Parameter Store

SSM Parameter Store lưu giữ ID AMI hiện tại mà mẫu khởi chạy (launch template) của nhóm Auto Scaling tham chiếu tới. Tham số được tạo với kiểu dữ liệu `aws:ec2:image`, cho phép chức năng `resolve:ssm:` của mẫu khởi chạy động phân giải ID AMI tại thời điểm khởi chạy.

![AWS Systems Manager Parameter Store](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/archblog-1212-image-7.png)
*SSM Parameter Store hiển thị tham số /oracle/ec2/ami-id.*

Khi Lambda cập nhật tham số này sau mỗi chu kỳ sao lưu, phiên bản tiếp theo do nhóm Auto Scaling khởi chạy sẽ tự động sử dụng AMI mới nhất.

### Bước 5: Thiết lập Auto Scaling Group với AMI động

Mẫu khởi chạy tham chiếu tham số SSM bằng tiền tố `resolve:ssm:` cho trường ID AMI. Đây là cơ chế gắn kết toàn bộ quy trình tự động hóa với nhau.

![Mẫu khởi chạy EC2](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/archblog-1212-image-8.png)
*Cấu hình AMI trong mẫu khởi chạy (Launch Template).*

Nhóm Auto Scaling được cấu hình với dung lượng tối thiểu, tối đa và mong muốn đều được đặt là 1. Đây không phải là auto-scaling truyền thống mà là một kiểu tự động phục hồi (self-healing). Mục đích duy nhất là phát hiện khi phiên bản Oracle không khỏe và tự động khởi chạy phiên bản thay thế.

Mẫu khởi chạy cũng bao gồm tập lệnh User Data chạy trên mỗi phiên bản mới để tự động kết nối cấu hình iSCSI và khởi động Oracle database.

![Nhóm EC2 Auto Scaling](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/archblog-1212-image-9.png)
*Nhóm Auto Scaling được cấu hình với min=max=desired=1.*

### Kiểm tra quy trình hoàn chỉnh

Để xác thực kiến trúc, hãy mô phỏng lỗi máy chủ bằng cách chấm dứt phiên bản EC2 Oracle hiện tại.
Trình tự dự kiến là:
1. Nhóm Auto Scaling phát hiện phiên bản bị lỗi (trong khoảng 30 giây).
2. Phiên bản mới được khởi chạy từ AMI mới nhất phân giải từ Parameter Store (khoảng 2 phút).
3. Tập lệnh User Data kết nối tới FSxN bằng iSCSI và khởi động Oracle (khoảng 2–3 phút).
4. Cơ sở dữ liệu Oracle khả dụng và chấp nhận kết nối (tổng thời gian: khoảng 5 phút).

![Lịch sử hoạt động của nhóm Auto Scaling](https://d2908q01vomqb2.cloudfront.net/fc074d501302eb2b93e2554793fcaf50b3bf7291/2026/05/22/archblog-1212-image-10.png)
*Lịch sử hoạt động của nhóm Auto Scaling cho thấy chuỗi tự phục hồi.*

### Dọn dẹp

Để tránh phát sinh các khoản phí trong tương lai, hãy xóa các tài nguyên:
- Xóa các hàm Lambda và quy tắc EventBridge.
- Xóa các Tham số từ Systems Manager Parameter Store.
- Xóa các kế hoạch và hầm AWS Backup.
- Hủy đăng ký các AMI đã tạo.
- Chấm dứt các phiên bản nhóm Auto Scaling.
- Xóa hệ thống tệp Amazon FSx for NetApp ONTAP.

## Phần kết luận

Kiến trúc này tạo điều kiện cho cơ sở dữ liệu Oracle có tính sẵn sàng cao với tính nhất quán về cấu hình bằng cách kết hợp lưu trữ chia sẻ liên tục FSxN, quản lý tự động AMI và bảo vệ thông qua AWS Backup. Nó đảm bảo các phiên bản được Auto Scaling thay thế luôn khởi chạy cấu hình Oracle mới nhất và kết nối với dữ liệu hiện có dễ dàng, nâng cao độ tin cậy của toàn bộ hệ thống.
