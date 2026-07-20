---
title: "Blog 5: Kiến trúc chuyển đổi dự phòng theo hướng sự kiện đa khu vực (Multi-Region) với Amazon EventBridge và Route 53"
date: 2026-06-01
weight: 5
chapter: false
pre: " <b> 3.5. </b> "
---

*bởi Napoleone Capasso và Fabio Frezza*
*vào ngày 01 Tháng 6, 2026*

Kiến trúc hướng sự kiện (Event-driven architectures) cho phép các ứng dụng phản hồi các sự kiện trong thời gian thực, cung cấp khả năng mở rộng và liên kết lỏng lẻo giữa các thành phần. Tuy nhiên, việc đảm bảo tính khả dụng cao trên nhiều khu vực (Region) AWS đòi hỏi phải thiết kế cẩn thận các cơ chế chuyển đổi dự phòng (failover). Bài viết này trình bày cách xây dựng một kiến trúc hướng sự kiện đa khu vực có khả năng phục hồi bằng cách sử dụng Amazon EventBridge, Amazon API Gateway và tính năng chuyển đổi dự phòng dựa trên tình trạng (health-based failover) của Amazon Route 53.

## Tổng quan

Các tổ chức xây dựng các ứng dụng hướng sự kiện cần đạt được khả năng sẵn sàng cao và khả năng phục hồi sau thảm họa. Kiến trúc này cung cấp tính năng chuyển đổi dự phòng tự động giữa các khu vực AWS trong khi vẫn duy trì tính độc lập của khu vực đối với việc xử lý sự kiện. Giải pháp này sử dụng các kiểm tra tình trạng (health checks) của Amazon Route 53 để giám sát các endpoint Amazon API Gateway của từng khu vực và tự động định tuyến lưu lượng truy cập đến các khu vực khỏe mạnh (healthy) mà không cần can thiệp thủ công.

Kiến trúc này mang lại một số lợi ích chính. Tính độc lập theo khu vực giúp giảm độ trễ bằng cách xử lý các sự kiện trong cùng khu vực nơi chúng bắt nguồn. Các bảng toàn cầu (Global Tables) của Amazon DynamoDB cung cấp tính năng tự động sao chép dữ liệu giữa các khu vực, đảm bảo dữ liệu luôn sẵn sàng trong các sự cố mất mạng cục bộ. Giải pháp cung cấp khả năng chuyển đổi dự phòng mạnh mẽ trong khi vẫn duy trì sự đơn giản của kiến trúc.

Các tổ chức với các yêu cầu khắt khe về tính khả dụng có thể thấy giải pháp này đặc biệt có giá trị. Tất cả các quá trình xử lý sự kiện vẫn nằm trong các khu vực AWS, và quá trình chuyển đổi dự phòng tự động diễn ra dựa trên kết quả kiểm tra tình trạng. Kiến trúc này hỗ trợ cả các thời điểm bảo trì theo kế hoạch lẫn việc ngừng hoạt động khu vực ngoài kế hoạch, cung cấp tính linh hoạt cho các nhu cầu vận hành.

## Tổng quan giải pháp

Giải pháp này triển khai kiến trúc đa khu vực hoạt động theo mô hình chủ động-bị động (active-passive), trong đó các sự kiện đi qua Amazon API Gateway tới các Amazon EventBridge bus của khu vực. Các kiểm tra tình trạng của Amazon Route 53 sẽ theo dõi khu vực chính và tự động định tuyến lưu lượng truy cập sang khu vực phụ (secondary) khi có sự cố. Mỗi khu vực sẽ xử lý các sự kiện một cách độc lập, trong khi các bảng toàn cầu của Amazon DynamoDB sao chép dữ liệu trên tất cả các khu vực.

Sơ đồ sau cung cấp cái nhìn tổng quan về giải pháp:

![Sơ đồ kiến trúc](https://d2908q01vomqb2.cloudfront.net/1b6453892473a467d07372d45eb05abc2031647a/2026/05/22/image-1-9.png)

Sơ đồ trên mô tả kiến trúc đa khu vực đang chạy trên hai khu vực AWS. Dịch vụ DNS Route 53 đóng vai trò là điểm vào chính (main entry point) cho ứng dụng, với các health checks để theo dõi cả hai khu vực. Mỗi khu vực chứa một ngăn xếp (stack) giống hệt nhau với Amazon API Gateway, Amazon EventBridge, Amazon SQS và AWS Lambda. Bảng toàn cầu Amazon DynamoDB tự động sao chép dữ liệu giữa các khu vực.

## Triển khai giải pháp

Để triển khai giải pháp này, hãy làm theo hướng dẫn trong kho lưu trữ GitHub và sao chép kho lưu trữ. Giải pháp triển khai tại hai khu vực AWS. Đảm bảo rằng có các chứng chỉ SSL hợp lệ trong AWS Certificate Manager (ACM) ở cả hai khu vực cho tên miền tùy chỉnh của bạn.

### Điều kiện tiên quyết

Đối với hướng dẫn này, cần có các tài nguyên sau:
- **Tài khoản AWS**: Một tài khoản AWS với quyền tạo và quản lý các tài nguyên Amazon API Gateway, Amazon EventBridge, Amazon SQS, AWS Lambda, Amazon DynamoDB, Amazon Route 53, AWS IAM và AWS CloudFormation.
- **AWS Serverless Application Model (SAM)**: Cần cài đặt AWS SAM CLI, vì các mẫu sử dụng phép biến đổi SAM cho các định nghĩa tài nguyên Lambda và API Gateway.
- **Tên miền (Domain Name)**: Tên miền đã đăng ký với Route 53 hosted zone.
- **Chứng chỉ SSL**: Các chứng chỉ ACM cho miền tùy chỉnh ở cả hai khu vực triển khai.
- **AWS CLI**: AWS CLI đã được cài đặt và cấu hình với thông tin xác thực cho tài khoản AWS mục tiêu.
- **Chọn khu vực (Region Selection)**: Hai khu vực AWS để triển khai.

## Hướng dẫn các bước

Các mẫu AWS CloudFormation từ kho lưu trữ GitHub mẫu tạo ra một kiến trúc đa khu vực an toàn, cung cấp khả năng chuyển đổi dự phòng tự động cho các ứng dụng hướng sự kiện. Các mẫu (templates) này cung cấp các endpoint API Gateway theo khu vực, các EventBridge bus, SQS queue, các hàm Lambda và một Bảng toàn cầu Amazon DynamoDB. Giải pháp thiết lập việc theo dõi tình trạng thông qua Route 53 health checks và cấu hình định tuyến DNS failover. Các mẫu sử dụng chuyển đổi AWS Serverless Application Model (SAM) để đơn giản hóa định nghĩa tài nguyên Lambda và API Gateway.

### Bước 1: Triển khai ngăn xếp chính (primary stack)

Ngăn xếp chính tạo ra các tài nguyên nền tảng ở khu vực chính. Điều này bao gồm Amazon EventBridge bus, Amazon API Gateway với miền tùy chỉnh, health check, hàm AWS Lambda, Amazon SQS queue và Bảng toàn cầu Amazon DynamoDB. Stack sẽ tạo ra một EventBridge bus để nhận các sự kiện từ API Gateway:
```yaml
EventBus: 
  Type: AWS::Events::EventBus 
  Properties: 
    Name: !Ref EventBusName
```
API Gateway sử dụng tích hợp dịch vụ AWS để chuyển tiếp các sự kiện trực tiếp tới EventBridge:
```yaml
x-amazon-apigateway-integration: 
  type: "aws" 
  uri: !Sub "arn:aws:apigateway:${AWS::Region}:events:path//" 
  credentials: !GetAtt ApiGatewayEventBridgeRole.Arn 
  httpMethod: "POST"
```
Health check giám sát API Gateway endpoint để xác định tính sẵn sàng của khu vực:
```yaml
DomainHealthCheck: 
  Type: AWS::Route53::HealthCheck 
  Properties: 
    HealthCheckConfig: 
      Type: HTTPS 
      ResourcePath: /Prod/health 
      FullyQualifiedDomainName: !Sub ${Api}.execute-api.${AWS::Region}.amazonaws.com 
      Port: 443 
      RequestInterval: 30 
      FailureThreshold: 3
```
Bản ghi DNS Route 53 cấu hình định tuyến chuyển đổi dự phòng (failover) với phân định PRIMARY:
```yaml
ApiDnsRecord:
  Type: AWS::Route53::RecordSet
  Properties:
    HostedZoneId: !Ref HostedZoneId
    Name: !Ref CustomDomainName
    Type: A
    SetIdentifier: primary-region
    Failover: PRIMARY
    HealthCheckId: !Ref DomainHealthCheck
```
Bảng toàn cầu DynamoDB tạo bản sao ở cả hai khu vực:
```yaml
DataTable: 
  Type: AWS::DynamoDB::GlobalTable 
  Properties: 
    BillingMode: PAY_PER_REQUEST 
    Replicas: 
      - Region: !Ref AWS::Region 
      - Region: !Ref SecondaryRegion
```
Lưu ý giá trị đầu ra `DataTableName` để sử dụng trong triển khai ngăn xếp phụ. Đầu ra `CustomDomainURL` cung cấp endpoint để gọi giải pháp.

### Bước 2: Triển khai ngăn xếp phụ (secondary stack)

Ngăn xếp phụ tạo ra các tài nguyên giống hệt ở khu vực phụ, ngoại trừ bảng Amazon DynamoDB sẽ tham chiếu tới Bảng toàn cầu hiện có. Ngăn xếp phụ sẽ tạo riêng cho nó Amazon EventBridge bus, Amazon API Gateway, health check, AWS Lambda function và Amazon SQS queue. Bản ghi DNS Route 53 sử dụng phân định SECONDARY.

### Bước 3: Luồng xử lý sự kiện

Các sự kiện luân chuyển qua pipeline xử lý ở mỗi khu vực. API Gateway nhận các sự kiện và chuyển tiếp chúng đến EventBridge bằng API `PutEvents`. EventBridge đánh giá các quy tắc sự kiện (event rules) và định tuyến các sự kiện phù hợp tới hàng đợi SQS. Các hàm Lambda tự động quét SQS queues và xử lý sự kiện theo lô (batches). AWS Lambda ghi dữ liệu đã xử lý vào Bảng toàn cầu DynamoDB, hệ thống tự động sao chép chéo giữa các khu vực.

Hàm Lambda xử lý các sự kiện từ hàng đợi và ghi vào DynamoDB:
```python
def handler(event, context): 
    for record in event.get('Records', []): 
        body = json.loads(record['body']) 
        detail = body.get('detail', {}) 
        event_id = body.get('id', '') 
        item = { 'id': event_id, 'detail': detail, 'timestamp': datetime.utcnow().isoformat() } 
        table.put_item(Item=item)
```

## Kiểm tra

Lấy URL miền tùy chỉnh và kiểm tra bằng cách gửi một sự kiện:
```bash
curl -X POST https://api.example.com \
-H "Content-Type: application/json" \
-d '{ "Detail": { "IsHelloWorldExample": "true" }, "DetailType": "POSTED", "Source": "demo.event" }' -v
```
Phản hồi sẽ bao gồm một header `X-Region` cho biết khu vực nào đã xử lý yêu cầu. Trong điều kiện bình thường, khu vực này sẽ hiển thị là khu vực chính.

Để kiểm tra failover (chuyển đổi dự phòng):
Xóa base path mapping cho khu vực chính:
```bash
aws apigateway delete-base-path-mapping \
  --domain-name api.example.com \
  --base-path '(none)' \
  --region {primary-region}
```
Xóa stage API Gateway chính:
```bash
aws apigateway delete-stage \
  --rest-api-id <primary-api-id> \
  --stage-name Prod \
  --region {primary-region}
```
Đợi 2-3 phút để quá trình kiểm tra tình trạng bị lỗi. Route 53 thực hiện kiểm tra mỗi 30 giây với ngưỡng lỗi là 3, vì vậy cần 90 giây để phát hiện ra lỗi.

Gửi yêu cầu khác tới endpoint API:
```bash
curl -X POST https://api.example.com \
-H "Content-Type: application/json" \
-d '{ "Detail": { "IsHelloWorldExample": "true" }, "DetailType": "POSTED", "Source": "demo.event" }' -v
```
Xác minh chuyển đổi dự phòng: Header `X-Region` lúc này sẽ hiển thị khu vực phụ, xác nhận việc chuyển đổi thành công.

Xác minh xử lý sự kiện ở khu vực phụ:
Kiểm tra logs của Lambda để xem quá trình xử lý có thành công không:
```bash
aws logs tail /aws/lambda/<secondary-lambda-name> --region {secondary region}
```
Bạn sẽ thấy các mục log tương tự như:
```
Processing message: 
{"version":"0", "id":"abc12345-...", "source":"demo.event", "detail-type":"POSTED",...} 
Event Source: demo.event
Detail Type: POSTED
Successfully wrote item to DynamoDB: abc12345-... 
Successfully read item from DynamoDB: 
{'id': 'abc12345-...', 'source': 'demo.event', 'detailType': 'POSTED', 'detail': {'data': {'IsHelloWorldExample': 'true'}, ...}, 'timestamp': '2025-01-15T18:30:00.000000', 'processed': True}
```

Xác minh dữ liệu trong Amazon DynamoDB:
```bash
aws dynamodb scan \
  --table-name <table-name> \
  --region {secondary region}
```
Kết quả scan sẽ bao gồm các mục với thông tin chi tiết sự kiện:
```json
{ "Items": 
[ { "id": {"S": "abc12345-..."}, 
"source": {"S": "demo.event"}, 
"detailType": {"S": "POSTED"},
"detail": {"M": {"data": {"M": {"IsHelloWorldExample": {"S": "true"}}}}}, 
"timestamp": {"S": "2025-01-15T18:30:00.000000"},
"processed": {"BOOL": true} } ], 
"Count": 1 }
```

Khôi phục khu vực chính – tạo lại stage:
```bash
aws apigateway create-stage \
  --rest-api-id <primary-api-id> \
  --stage-name Prod \
  --deployment-id <deployment-id> \
  --region {primary region}
```
Khôi phục khu vực chính – tạo lại base path mapping:
```bash
aws apigateway create-base-path-mapping \
  --domain-name api.example.com \
  --rest-api-id <primary-api-id> \
  --stage Prod \
  --region {primary region}
```
Bạn có thể tìm thấy “deployment-id” bằng cách chạy:
```bash
aws apigateway get-deployments \
  --rest-api-id <primary-api-id> \
  --region {primary region}
```
Sau 2-3 phút, kiểm tra tình trạng thành công và Route 53 sẽ định tuyến lại lưu lượng truy cập về khu vực chính.

## Dọn dẹp

Để loại bỏ giải pháp và tránh các khoản chi phí liên tục, hãy xóa các ngăn xếp CloudFormation theo đúng thứ tự. Xóa ngăn xếp phụ trước, sau đó xóa ngăn xếp chính. Thứ tự này rất quan trọng vì Bảng toàn cầu Amazon DynamoDB được sở hữu bởi ngăn xếp chính. 
**Cảnh báo**: Việc xóa các ngăn xếp này sẽ vĩnh viễn xóa tất cả các tài nguyên bao gồm cả Bảng toàn cầu Amazon DynamoDB và mọi dữ liệu sự kiện được lưu trữ trong đó. Hãy sao lưu bất kỳ dữ liệu nào bạn cần trước khi tiếp tục. Hành động này không thể hoàn tác.

Các tài nguyên sau sẽ tính phí khi được triển khai:
- Amazon API Gateway (REST API)
- Amazon Route 53 health checks và các bản ghi DNS
- Bảng toàn cầu Amazon DynamoDB (với tính năng sao chép xuyên khu vực)
- Số lần gọi hàm AWS Lambda và thời lượng chạy
- Các hoạt động của hàng đợi Amazon SQS
- Không gian lưu trữ Amazon CloudWatch Logs

Xóa ngăn xếp phụ:
```bash
aws cloudformation delete-stack --stack-name secondary-stack --region {secondary region}
```
Chờ việc xóa ngăn xếp phụ hoàn tất:
```bash
aws cloudformation wait stack-delete-complete --stack-name secondary-stack --region {secondary region}
```
Xóa ngăn xếp chính:
```bash
aws cloudformation delete-stack --stack-name primary-stack --region {primary region}
```
Chờ việc xóa ngăn xếp chính hoàn tất:
```bash
aws cloudformation wait stack-delete-complete --stack-name primary-stack --region {primary region}
```
Điều này loại bỏ toàn bộ tài nguyên bao gồm Amazon EventBridge buses, Amazon API Gateways, AWS Lambda functions, Amazon SQS queues, Bảng toàn cầu Amazon DynamoDB, Amazon Route 53 health checks, DNS records và IAM roles.

## Kết luận

Bài viết này đã minh họa cách thiết lập một kiến trúc đa khu vực có khả năng phục hồi tốt cho các ứng dụng hướng sự kiện bằng Amazon EventBridge, Amazon API Gateway, và Amazon Route 53. Giải pháp này sử dụng khả năng chuyển đổi dự phòng dựa trên tình trạng của Route 53, một tính năng mạnh mẽ có thể tự động định tuyến lưu lượng truy cập đến các khu vực khỏe mạnh dựa trên kết quả health check. Kiến trúc này nâng cao đáng kể tính sẵn sàng của ứng dụng bằng cách cung cấp chuyển đổi tự động trong thời gian xảy ra sự cố ngừng trệ theo khu vực, đồng thời vẫn duy trì tính độc lập để xử lý sự kiện.
