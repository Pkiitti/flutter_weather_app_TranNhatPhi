import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../models/forecast_model.dart';
import '../providers/weather_provider.dart';

class HourlyForecastList extends StatelessWidget {
  final List<ForecastModel> forecasts;

  const HourlyForecastList({required this.forecasts});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();
    final hourlyList = forecasts.take(8).toList();

    return Container(
      height: 130,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: hourlyList.length,
        itemBuilder: (context, index) {
          final item = hourlyList[index];

          double displayTemp = item.temperature;
          if (!provider.isCelsius) {
            displayTemp = (item.temperature * 9 / 5) + 32;
          }

          String timeFormat = provider.is24Hour ? 'HH:mm' : 'h:mm a';

          return Container(
            width: 80,
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat(timeFormat).format(item.dateTime),
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                    CachedNetworkImage(
                      imageUrl: 'https://openweathermap.org/img/wn/${item.icon}.png',
                      height: 40,
                      errorWidget: (context, url, error) => Icon(Icons.error, size: 20),
                    ),
                    Text(
                      '${displayTemp.round()}°',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}