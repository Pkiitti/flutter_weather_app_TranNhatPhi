import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Đọc dữ liệu từ Provider
    final provider = context.watch<WeatherProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cài đặt', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          SwitchListTile(
            title: Text('Nhiệt độ (Celsius/Fahrenheit)'),
            subtitle: Text(provider.isCelsius ? 'Celsius (°C)' : 'Fahrenheit (°F)'),
            value: provider.isCelsius,
            onChanged: (val) => provider.updateSettings(isCelsius: val),
          ),
          SwitchListTile(
            title: Text('Định dạng giờ (12/24h)'),
            subtitle: Text(provider.is24Hour ? '24 giờ' : '12 giờ'),
            value: provider.is24Hour,
            onChanged: (val) => provider.updateSettings(is24Hour: val),
          ),
          ListTile(
            title: Text('Đơn vị sức gió'),
            trailing: DropdownButton<String>(
              value: provider.windSpeedUnit,
              items: ['m/s', 'km/h', 'mph'].map((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
              }).toList(),
              onChanged: (val) => provider.updateSettings(windUnit: val),
            ),
          ),
        ],
      ),
    );
  }
}