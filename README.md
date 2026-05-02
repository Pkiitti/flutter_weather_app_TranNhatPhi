-  Weather App - Flutter Lab 4
Sinh viên thực hiện: Trần Nhật Phi

Mã số sinh viên: 2224802010436

-  Mô tả dự án
Đây là ứng dụng dự báo thời tiết toàn diện được xây dựng bằng Flutter. Ứng dụng tích hợp API từ OpenWeatherMap để cung cấp thông tin thời tiết thời gian thực dựa trên vị trí GPS của người dùng hoặc tìm kiếm theo tên thành phố. Dự án tập trung vào việc quản lý trạng thái (State Management), xử lý bất đồng bộ, lưu trữ bộ nhớ đệm (Caching) và thiết kế giao diện động theo điều kiện thời tiết.

-  Tính năng chính (Core Features)
Vị trí tự động: Tự động phát hiện vị trí hiện tại qua GPS để hiển thị thời tiết.

Thông tin thời tiết chi tiết: Hiển thị nhiệt độ, cảm giác thực tế, độ ẩm, tốc độ gió, áp suất và tầm nhìn.

Dự báo linh hoạt: Cung cấp dự báo thời tiết theo giờ (24h tới) và dự báo hàng ngày (5 ngày tới).

Tìm kiếm thông minh: Tìm kiếm thời tiết tại bất kỳ thành phố nào trên thế giới.

Lịch sử & Yêu thích: Lưu lịch sử tìm kiếm và danh sách các thành phố yêu thích (tối đa 5 địa điểm).

Chế độ ngoại tuyến: Lưu trữ dữ liệu thời tiết gần nhất để người dùng có thể xem khi không có internet.

Tùy chỉnh cài đặt: Cho phép thay đổi đơn vị nhiệt độ (°C/°F), định dạng giờ (12h/24h) và đơn vị tốc độ gió.

<img width="365" height="787" alt="image" src="https://github.com/user-attachments/assets/f801b212-d002-426e-b02d-7da56b142753" />

<img width="444" height="798" alt="image" src="https://github.com/user-attachments/assets/7e4c5435-a09a-45a5-a257-a39a2888dbed" />


<img width="369" height="346" alt="image" src="https://github.com/user-attachments/assets/a9bd8da8-bf79-4aec-b635-ef8f040ff65e" />

<img width="344" height="168" alt="image" src="https://github.com/user-attachments/assets/601c7c75-fdeb-422e-bbee-827e0c51e877" />

<img width="380" height="389" alt="image" src="https://github.com/user-attachments/assets/e78cf7ba-3c06-4bb8-bf83-f544244928ff" />

<img width="401" height="510" alt="image" src="https://github.com/user-attachments/assets/c38604fb-7af2-4d41-a661-ee3c4244e0ae" />




-  Công nghệ sử dụng
Ngôn ngữ: Dart & Framework Flutter.

Quản lý trạng thái: Provider Pattern.

Thư viện chính: - http: Gọi REST API.

geolocator & geocoding: Xử lý vị trí và địa lý.

shared_preferences: Lưu trữ bộ nhớ đệm và cài đặt người dùng.

flutter_dotenv: Quản lý biến môi trường bảo mật API Key.

cached_network_image: Hiển thị và lưu tạm icon thời tiết.

-  Hướng dẫn cài đặt và Chạy dự án
1. Yêu cầu hệ thống
Flutter SDK bản mới nhất.

Android Studio / VS Code.

2. Thiết lập API Key (Quan trọng)
Ứng dụng sử dụng API từ OpenWeatherMap. Để chạy được ứng dụng, bạn cần thực hiện:

Đăng ký tài khoản tại OpenWeatherMap để lấy API Key miễn phí.

Tại thư mục gốc của dự án, tạo file mới tên là .env.

Mở file .env và dán mã API Key của bạn vào:

Đoạn mã
OPENWEATHER_API_KEY=your_actual_key_here
