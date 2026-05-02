# 🌦️ Weather App - Flutter Lab 4

**Sinh viên thực hiện:** Trần Nhật Phi

**Mã số sinh viên:** 2224802010436

**DEMO:** https://drive.google.com/drive/folders/1fHC9AEpOUWFGhPetvviB5U9yOCxdwLxF?usp=sharing 
---

## 📝 Mô tả dự án
Đây là ứng dụng dự báo thời tiết toàn diện được xây dựng bằng Flutter. Ứng dụng tích hợp API từ OpenWeatherMap để cung cấp thông tin thời tiết thời gian thực dựa trên vị trí GPS của người dùng hoặc tìm kiếm theo tên thành phố. Dự án tập trung vào việc quản lý trạng thái (State Management), xử lý bất đồng bộ, lưu trữ bộ nhớ đệm (Caching) và thiết kế giao diện động theo điều kiện thời tiết.

## ✨ Tính năng chính (Core Features)
* Vị trí tự động: Tự động phát hiện vị trí hiện tại qua GPS để hiển thị thời tiết.
* Thông tin thời tiết chi tiết: Hiển thị nhiệt độ, cảm giác thực tế, độ ẩm, tốc độ gió, áp suất và tầm nhìn.
* Dự báo linh hoạt: Cung cấp dự báo thời tiết theo giờ (24h tới) và dự báo hàng ngày (5 ngày tới).
* Tìm kiếm thông minh: Tìm kiếm thời tiết tại bất kỳ thành phố nào trên thế giới.
* Lịch sử & Yêu thích: Lưu lịch sử tìm kiếm và danh sách các thành phố yêu thích (tối đa 5 địa điểm).
* Chế độ ngoại tuyến: Lưu trữ dữ liệu thời tiết gần nhất để người dùng có thể xem khi không có internet.
* Tùy chỉnh cài đặt: Cho phép thay đổi đơn vị nhiệt độ (°C/°F), định dạng giờ (12h/24h) và đơn vị tốc độ gió.

## 🖼️ Ảnh chụp màn hình (Screenshots)
- Screenshot 1: <img width="342" height="774" alt="image" src="https://github.com/user-attachments/assets/736b84a2-b53a-4b7b-a274-11c370870173" />

- Screenshot 2: <img width="369" height="796" alt="image" src="https://github.com/user-attachments/assets/4c04d078-6b97-44c9-907b-8801dee21ffb" />

- Screenshot 3: <img width="370" height="797" alt="image" src="https://github.com/user-attachments/assets/a72626ee-a170-45c7-b30b-38c8142a032d" />

- Screenshot 4: <img width="363" height="797" alt="image" src="https://github.com/user-attachments/assets/e6c3d54f-9ce8-44de-bcbc-8fed2f6422f4" />

- Screenshot 5: <img width="361" height="798" alt="image" src="https://github.com/user-attachments/assets/4630c046-671b-43c3-a777-f9b1bb695d27" />

## 🛠️ Công nghệ sử dụng
* Ngôn ngữ: Dart & Framework Flutter.
* Quản lý trạng thái: Provider Pattern.
* Thư viện chính: 
    - http: Gọi REST API.
    - geolocator & geocoding: Xử lý vị trí và địa lý.
    - shared_preferences: Lưu trữ bộ nhớ đệm và cài đặt người dùng.
    - flutter_dotenv: Quản lý biến môi trường bảo mật API Key.
    - cached_network_image: Hiển thị và lưu tạm icon thời tiết.

## ⚙️ Hướng dẫn cài đặt và Chạy dự án
1. Yêu cầu hệ thống
* Flutter SDK bản mới nhất.
* Android Studio / VS Code.

2. Thiết lập API Key (Quan trọng)
Ứng dụng sử dụng API từ OpenWeatherMap. Để chạy được ứng dụng, bạn cần thực hiện:
* Đăng ký tài khoản tại OpenWeatherMap để lấy API Key miễn phí.
* Tại thư mục gốc của dự án, tạo file mới tên là .env.
* Mở file .env và dán mã API Key của bạn vào:
  OPENWEATHER_API_KEY=your_actual_key_here
