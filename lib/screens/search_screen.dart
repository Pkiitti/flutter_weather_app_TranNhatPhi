import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../services/storage_service.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _favoriteCities = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final storage = context.read<StorageService>();
    final favs = await storage.getFavoriteCities();
    setState(() {
      _favoriteCities = favs;
    });
  }

  Future<void> _saveFavorite(String city) async {
    if (!_favoriteCities.contains(city) && city.isNotEmpty) {
      setState(() {
        if (_favoriteCities.length >= 5) _favoriteCities.removeAt(0); // Chỉ giữ tối đa 5 thành phố
        _favoriteCities.add(city);
      });
      await context.read<StorageService>().saveFavoriteCities(_favoriteCities);
    }
  }

  void _performSearch(String cityName) {
    if (cityName.trim().isNotEmpty) {
      _saveFavorite(cityName.trim());
      context.read<WeatherProvider>().fetchWeatherByCity(cityName.trim());
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tìm kiếm thành phố', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              autofocus: true,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Ví dụ: Hanoi, London, Tokyo...',
                prefixIcon: Icon(Icons.search, color: Colors.blueAccent),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () => _searchController.clear(),
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                ),
              ),
              onSubmitted: (value) => _performSearch(value),
            ),
            SizedBox(height: 30),
            if (_favoriteCities.isNotEmpty) ...[
              Text('Lịch sử & Yêu thích (Tối đa 5):', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700])),
              SizedBox(height: 15),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: _favoriteCities.map((city) {
                  return ActionChip(
                    elevation: 2,
                    backgroundColor: Colors.blue[50],
                    label: Text(city, style: TextStyle(color: Colors.blue[900])),
                    avatar: Icon(Icons.history, size: 16, color: Colors.blue[900]),
                    onPressed: () => _performSearch(city),
                  );
                }).toList(),
              ),
            ]
          ],
        ),
      ),
    );
  }
}