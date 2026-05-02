import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Import services & providers
import 'config/api_config.dart';
import 'services/location_service.dart';
import 'services/storage_service.dart';
import 'services/weather_service.dart';
import 'providers/weather_provider.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  runApp(
    MultiProvider(
      providers: [
        Provider<LocationService>(create: (_) => LocationService()),
        Provider<StorageService>(create: (_) => StorageService()),
        Provider<WeatherService>(
          create: (_) => WeatherService(apiKey: ApiConfig.apiKey),
        ),
        ChangeNotifierProvider<WeatherProvider>(
          create: (context) => WeatherProvider(
            context.read<WeatherService>(),
            context.read<LocationService>(),
            context.read<StorageService>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}