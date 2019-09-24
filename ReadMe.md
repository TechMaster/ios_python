Ví dụ IOS Client kết nối lên Python Rest Server
Written by Cường và học sinh của Cường




Các vấn đề khi lập trình kết nối REST API

1- Phải hiểu cấu trúc dữ liệu JSON trả về
Back end developer sẽ cung cấp API Document

2- Lập trình viên mobile có phải lập trình cả back end không?
Với ứng dụng nhỏ, mobile dev sẽ phải lập trình cả back end.
Trong ứng dụng chuyên nghiệp, mobile dev sẽ không phải lập trình back end. Lúc này mobile dev cần tập trung mấy nhiệm vụ chính:
+ Lập trình giao diện đẹp, thân thiện
+ Kiểm thử trên nhiều thiết bị khác nhau

Việc back end sẽ gồm có:
+ Đáp ứng đúng nghiệp vụ (meet business requirements)
+ Đảm bảo dịch vụ ổn định (high availablity)
+ Tốc độ trả về nhanh (fast response)
+ Bảo mật (secured)

Sớm muộn các bạn phải tập trung vào thiết kế UI/UX tốt, lập trình ứng dụng di động đẹp. Nếu công ty yêu cầu chạy trên cả 2 nền tảng thì dev di động cần phải chuyển sang React Native hoặc Flutter.


Quay lại bài trước, chúng ta gặp những khó khăn gì?
+ Update record in server. Server đã nhận. Lỗi khi reload table view

Một số giải pháp:
....



Các bước để xây dựng một ứng dụng di động kết nối REST

1. Hình thành cấu trúc thư mục khoa học
2. Có tạo thư mục doc để chứa các tài liệu (thiết kế và tham khảo)
3. Tạo gitrepo để quản lý phiên bản trên github 
  - tạo .gitignore


Phía các sinh viên hãy gõ lệnh
lần đầu
```
git clone https://github.com/TechMaster/ios_python.git
```
lần tiếp theo
```
git pull
```


