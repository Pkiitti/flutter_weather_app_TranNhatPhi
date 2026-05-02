import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../models/weather_model.dart';
import '../providers/weather_provider.dart';

class CurrentWeatherCard extends StatelessWidget {
  final WeatherModel weather;

  const CurrentWeatherCard({required this.weather});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();
    double displayTemp = weather.temperature;
    double displayFeelsLike = weather.feelsLike;
    String unit = '°C';

    if (!provider.isCelsius) {
      displayTemp = (weather.temperature * 9 / 5) + 32;
      displayFeelsLike = (weather.feelsLike * 9 / 5) + 32;
      unit = '°F';
    }

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: _getWeatherGradient(weather.mainCondition),
      ),
      child: Column(
        children: [
          SizedBox(height: 40),
          Text(
            weather.cityName,
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
          Text(
            DateFormat('EEEE, MMM d').format(weather.dateTime),
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
          SizedBox(height: 20),
          CachedNetworkImage(
            imageUrl: 'https://openweathermap.org/img/wn/${weather.icon}@4x.png',
            height: 120,
            errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.white),
          ),
          Text(
            '${displayTemp.round()}$unit',
            style: TextStyle(fontSize: 80, color: Colors.white),
          ),
          Text(
            weather.description.toUpperCase(),
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          Text(
            'Feels like ${displayFeelsLike.round()}$unit',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  LinearGradient _getWeatherGradient(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return LinearGradient(
          colors: [Color(0xFF4A90E2), Color(0xFF87CEEB)],
          begin: Alignment.topCenter, end: Alignment.bottomCenter,
        );
      case 'rain':
        return LinearGradient(
          colors: [Color(0xFF4A5568), Color(0xFF718096)],
          begin: Alignment.topCenter, end: Alignment.bottomCenter,
        );
      default:
        return LinearGradient(
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          begin: Alignment.topCenter, end: Alignment.bottomCenter,
        );
    }
  }
}