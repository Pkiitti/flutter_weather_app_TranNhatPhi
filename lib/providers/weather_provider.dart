import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import '../services/weather_service.dart';
import '../services/location_service.dart';
import '../services/storage_service.dart';

enum WeatherState { initial, loading, loaded, error }

class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService;
  final LocationService _locationService;
  final StorageService _storageService;

  WeatherModel? _currentWeather;
  List<ForecastModel> _forecast = [];
  WeatherState _state = WeatherState.initial;
  String _errorMessage = '';
  bool _isCelsius = true;
  bool _is24Hour = true;
  String _windSpeedUnit = 'm/s';

  WeatherProvider(
      this._weatherService,
      this._locationService,
      this._storageService,
      ) {
    _loadSettings();
  }

  bool get isCelsius => _isCelsius;
  bool get is24Hour => _is24Hour;
  String get windSpeedUnit => _windSpeedUnit;

  WeatherModel? get currentWeather => _currentWeather;
  List<ForecastModel> get forecast => _forecast;
  WeatherState get state => _state;
  String get errorMessage => _errorMessage;

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isCelsius = prefs.getBool('isCelsius') ?? true;
    _is24Hour = prefs.getBool('is24Hour') ?? true;
    _windSpeedUnit = prefs.getString('windSpeedUnit') ?? 'm/s';
    notifyListeners();
  }

  Future<void> updateSettings({bool? isCelsius, bool? is24Hour, String? windUnit}) async {
    final prefs = await SharedPreferences.getInstance();
    if (isCelsius != null) {
      _isCelsius = isCelsius;
      await prefs.setBool('isCelsius', isCelsius);
    }
    if (is24Hour != null) {
      _is24Hour = is24Hour;
      await prefs.setBool('is24Hour', is24Hour);
    }
    if (windUnit != null) {
      _windSpeedUnit = windUnit;
      await prefs.setString('windSpeedUnit', windUnit);
    }
    notifyListeners();
  }

  Future<void> fetchWeatherByCity(String cityName) async {
    _state = WeatherState.loading;
    notifyListeners();
    try {
      _currentWeather = await _weatherService.getCurrentWeatherByCity(cityName);
      _forecast = await _weatherService.getForecast(cityName);
      await _storageService.saveWeatherData(_currentWeather!);
      _state = WeatherState.loaded;
      _errorMessage = '';
    } catch (e) {
      _state = WeatherState.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> fetchWeatherByLocation() async {
    _state = WeatherState.loading;
    notifyListeners();
    try {
      final position = await _locationService.getCurrentLocation();
      _currentWeather = await _weatherService.getCurrentWeatherByCoordinates(
        position.latitude,
        position.longitude,
      );
      final cityName = await _locationService.getCityName(
        position.latitude,
        position.longitude,
      );
      _forecast = await _weatherService.getForecast(cityName);
      await _storageService.saveWeatherData(_currentWeather!);
      _state = WeatherState.loaded;
      _errorMessage = '';
    } catch (e) {
      _state = WeatherState.error;
      _errorMessage = e.toString();
      await loadCachedWeather();
    }
    notifyListeners();
  }

  Future<void> loadCachedWeather() async {
    final cachedWeather = await _storageService.getCachedWeather();
    if (cachedWeather != null) {
      _currentWeather = cachedWeather;
      _state = WeatherState.loaded;
      notifyListeners();
    }
  }

  Future<void> refreshWeather() async {
    if (_currentWeather != null) {
      await fetchWeatherByCity(_currentWeather!.cityName);
    } else {
      await fetchWeatherByLocation();
    }
  }
}