import 'package:flutter/material.dart';
import 'package:weather_forecasting/services/weather_service.dart';
import 'package:weather_forecasting/weather_screen.dart';

class WeatherInfo extends StatefulWidget {
  const WeatherInfo({super.key});

  @override
  State<WeatherInfo> createState() => _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo> {
  final WeatherService weatherService = WeatherService();
  late Future<Map<String, dynamic>?> _weatherData;

  @override
  void initState() {
    super.initState();
    //The lat/lon location here (Cairo)
    _weatherData = weatherService.fetchWeatherData(45.6081, 6.8365);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _weatherData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching weather data.'));
          } else if (snapshot.hasData) {
            final weather = snapshot.data;
            return weather != null
                ? WeatherScreen(weather: weather)
                : const Center(child: Text('No data available.'));
          } else {
            return const Center(child: Text('Failed to load weather data.'));
          }
        },
      ),
    );
  }
}
