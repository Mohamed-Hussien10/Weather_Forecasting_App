import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_forecasting/services/location_service.dart';
import 'package:weather_forecasting/services/weather_service.dart';
import 'package:weather_forecasting/weather_screen.dart';

class WeatherInfo extends StatefulWidget {
  const WeatherInfo({super.key});

  @override
  State<WeatherInfo> createState() => _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo> {
  final LocationService locationService = LocationService();
  final WeatherService weatherService = WeatherService();
  Future<Map<String, dynamic>?>? _weatherData; // Use nullable type for future
  late double lat;
  late double long;

  @override
  void initState() {
    super.initState();
    _getLocationAndWeather(); // Fetch location and weather data
  }

  Future<void> _getLocationAndWeather() async {
    // Fetch the location
    await locationService.fetchLocation((latitude, longitude) {
      setState(() {
        // After getting the location, fetch the weather data
        _weatherData = weatherService.fetchWeatherData(latitude, longitude);
        lat = latitude;
        long = longitude;
      });
      if (kDebugMode) {
        print('Fetched coordinates: $latitude, $longitude');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _weatherData,
        builder: (context, snapshot) {
          // Check if _weatherData is still null, indicating that location fetching is in progress
          if (_weatherData == null) {
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
          } else if (snapshot.connectionState == ConnectionState.waiting) {
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
                ? WeatherScreen(
                    weather: weather,
                    latitude: lat,
                    longitude: long,
                  )
                : const Center(child: Text('No data available.'));
          } else {
            return const Center(child: Text('Failed to load weather data.'));
          }
        },
      ),
    );
  }
}
