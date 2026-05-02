import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

void main() {
  group('WeatherService Tests', () {
    test('Parse weather JSON correctly', () {
      // Giả lập (Mock) chuỗi JSON trả về từ API
      final json = {
        'name': 'Ho Chi Minh City',
        'sys': {'country': 'VN'},
        'main': {
          'temp': 25.0,
          'feels_like': 27.0,
          'humidity': 80,
          'pressure': 1010,
          'temp_min': 24.0,
          'temp_max': 26.0,
        },
        'wind': {'speed': 3.5},
        'weather': [
          {
            'description': 'scattered clouds',
            'icon': '03d',
            'main': 'Clouds',
          }
        ],
        'dt': 1620000000,
        'visibility': 10000,
        'clouds': {'all': 40},
      };

      final weather = WeatherModel.fromJson(json);

      // Kiểm tra dữ liệu xem có parse đúng như cấu trúc class không
      expect(weather.temperature, 25.0);
      expect(weather.cityName, 'Ho Chi Minh City');
      expect(weather.country, 'VN');
    });

    test('Handle API error gracefully', () {
      final weatherService = WeatherService(apiKey: 'fake_invalid_key_for_test');

      // Kiểm tra chức năng ném lỗi (throwsException) khi nhập sai tên thành phố
      expect(
            () => weatherService.getCurrentWeatherByCity('InvalidCityName12345'),
        throwsException,
      );
    });
  });
}