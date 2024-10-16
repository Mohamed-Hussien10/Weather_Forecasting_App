import 'package:flutter/material.dart';
import 'package:weather_forecasting/search_screen.dart';
import 'package:weather_forecasting/services/weather_service.dart';

// ignore: must_be_immutable
class SearchInfo extends StatefulWidget {
  SearchInfo(this.lat, this.long, {super.key});
  double lat;
  double long;

  @override
  State<SearchInfo> createState() => _SearchInfoState();
}

class _SearchInfoState extends State<SearchInfo> {
  final WeatherService weatherService = WeatherService();
  Future<Map<String, dynamic>?>? _weatherData; // Use nullable type for future
  @override
  void initState() {
    super.initState();
    _getWeather(); // Fetch location and weather data
  }

  Future<void> _getWeather() async {
    print("Searching for weather: ${widget.lat} ${widget.long}");
    setState(() {
      // fetch the weather data
      _weatherData = weatherService.fetchWeatherData(widget.lat, widget.long);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _weatherData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                width: 150,
                height: 2,
                child: LinearProgressIndicator(
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.deepPurpleAccent), // Color of the indicator
                  backgroundColor:
                      Colors.grey[300], // Background color of the bar
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching weather data.'));
          } else if (snapshot.hasData) {
            final weather = snapshot.data;
            return weather != null
                ? SearchScreen(weather)
                : const Center(child: Text('No data available.'));
          } else {
            return const Center(child: Text('Failed to load weather data.'));
          }
        },
      ),
    );
  }
}
