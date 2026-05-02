import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../models/forecast_model.dart';
import '../providers/weather_provider.dart';

class DailyForecastSection extends StatelessWidget {
  final List<ForecastModel> forecasts;

  const DailyForecastSection({required this.forecasts});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();
    final simpleDailyList = [
      for (var i = 0; i < forecasts.length; i += 8) forecasts[i]
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dự báo 5 ngày tới',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[800]),
              ),
              SizedBox(height: 10),
              ...simpleDailyList.map((item) {
                double displayTemp = item.temperature;
                if (!provider.isCelsius) {
                  displayTemp = (item.temperature * 9 / 5) + 32;
                }
                return _buildDailyItem(item, displayTemp);
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDailyItem(ForecastModel item, double displayTemp) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              DateFormat('EEEE, d MMM').format(item.dateTime),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 1,
            child: CachedNetworkImage(
              imageUrl: 'https://openweathermap.org/img/wn/${item.icon}.png',
              height: 40,
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${displayTemp.round()}°',
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}