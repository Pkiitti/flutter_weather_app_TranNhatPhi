import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/current_weather_card.dart';
import '../widgets/loading_shimmer.dart';
import '../widgets/error_widget.dart';
import '../widgets/hourly_forecast_list.dart';
import '../widgets/daily_forecast_card.dart';
import '../widgets/weather_detail_item.dart';
import 'search_screen.dart';
import 'settings_screen.dart'; // <-- Bổ sung import Settings Screen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherProvider>().fetchWeatherByLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black54),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SettingsScreen())
            ),
          )
        ],
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, provider, child) {
          // Trạng thái 1: Đang tải dữ liệu
          if (provider.state == WeatherState.loading) {
            return LoadingShimmer();
          }

          // Trạng thái 2: Lỗi
          if (provider.state == WeatherState.error) {
            return ErrorWidgetCustom(
              message: provider.errorMessage,
              onRetry: () => provider.fetchWeatherByLocation(),
            );
          }

          // Trạng thái 3: Không có dữ liệu
          if (provider.currentWeather == null) {
            return Center(child: Text('Không có dữ liệu thời tiết'));
          }

          // Trạng thái 4: Thành công -> Mới cho phép kéo để refresh
          return RefreshIndicator(
            onRefresh: () => provider.refreshWeather(),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  CurrentWeatherCard(weather: provider.currentWeather!),
                  HourlyForecastList(forecasts: provider.forecast),
                  DailyForecastSection(forecasts: provider.forecast),
                  WeatherDetailsSection(weather: provider.currentWeather!),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => SearchScreen()),
        ),
        child: Icon(Icons.search),
      ),
    );
  }
}