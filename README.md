# 🌦️ Weather App - Flutter Lab 4

**Sinh viên thực hiện:** Trần  Nhật  Phi 
**Mã số sinh viên:** 2224802010436 


---

## 📝 Mô tả dự án
Đây là ứng dụng dự báo thời tiết toàn diện được xây dựng bằng Flutter. [cite_start]Ứng dụng tích hợp API từ OpenWeatherMap để cung cấp thông tin thời tiết thời gian thực dựa trên vị trí GPS của người dùng hoặc tìm kiếm theo tên thành phố[cite: 3]. [cite_start]Dự án tập trung vào việc quản lý trạng thái (State Management), xử lý bất đồng bộ, lưu trữ bộ nhớ đệm (Caching) và thiết kế giao diện động theo điều kiện thời tiết [cite: 4-12].

## ✨ Tính năng chính (Core Features)
- **Vị trí tự động:** Tự động phát hiện vị trí hiện tại qua GPS để hiển thị thời tiết[cite: 658].
- **Thông tin thời tiết chi tiết:** Hiển thị nhiệt độ, cảm giác thực tế, độ ẩm, tốc độ gió, áp suất và tầm nhìn [cite: 634-646].
- **Dự báo linh hoạt:** Cung cấp dự báo thời tiết theo giờ (24h tới) và dự báo hàng ngày (5 ngày tới) [cite: 647-651].
- [cite_start]**Tìm kiếm thông minh:** Tìm kiếm thời tiết tại bất kỳ thành phố nào trên thế giới[cite: 653].
- [cite_start]**Lịch sử & Yêu thích:** Lưu lịch sử tìm kiếm và danh sách các thành phố yêu thích (tối đa 5 địa điểm) [cite: 654-656].
- [cite_start]**Chế độ ngoại tuyến:** Lưu trữ dữ liệu thời tiết gần nhất để người dùng có thể xem khi không có internet [cite: 661-664].
- [cite_start]**Tùy chỉnh cài đặt:** Cho phép thay đổi đơn vị nhiệt độ (°C/°F), định dạng giờ (12h/24h) và đơn vị tốc độ gió [cite: 665-668].

## 🛠️ Công nghệ sử dụng
- **Ngôn ngữ:** Dart & Framework Flutter.
- [cite_start]**Quản lý trạng thái:** Provider Pattern[cite: 89, 426].
- [cite_start]**Thư viện chính:** - `http`: Gọi REST API[cite: 86].
  - [cite_start]`geolocator` & `geocoding`: Xử lý vị trí và địa lý [cite: 87-88].
  - [cite_start]`shared_preferences`: Lưu trữ bộ nhớ đệm và cài đặt người dùng[cite: 90].
  - [cite_start]`flutter_dotenv`: Quản lý biến môi trường bảo mật API Key[cite: 93, 736].
  - [cite_start]`cached_network_image`: Hiển thị và lưu tạm icon thời tiết[cite: 92].

## ⚙️ Hướng dẫn cài đặt và Chạy dự án

### 1. Yêu cầu hệ thống
- Flutter SDK bản mới nhất.
- Android Studio / VS Code.

### 2. Thiết lập API Key (Quan trọng)
Ứng dụng sử dụng API từ **OpenWeatherMap**. [cite_start]Để chạy được ứng dụng, bạn cần thực hiện [cite: 741-744]:
1. Đăng ký tài khoản tại [OpenWeatherMap](https://home.openweathermap.org/users/sign_up) để lấy API Key miễn phí.
2. Tại thư mục gốc của dự án, copy file `.env.example` thành file mới tên là `.env`.
3. Mở file `.env` và dán mã API Key của bạn vào:
   ```env
   OPENWEATHER_API_KEY=your_actual_key_here
