import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherService {
  final String _baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  Future<Map<String, dynamic>?> fetchWeatherData(
      double latitude, double longitude) async {
    final String apiKey = dotenv.env['OPENWEATHER_API_KEY'] ?? '';
    final url = Uri.parse(
        '$_baseUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to fetch weather data');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching weather data: $error');
      }
      return null;
    }
  }

  //----------------------------------------------------------------
  final String _baseUrlf = "https://api.openweathermap.org/data/2.5/forecast";

  Future<Map<String, dynamic>?> fetchFiveDayForecast(
      double latitude, double longitude) async {
    final String apiKey = dotenv.env['FORCASTING_API_KEY'] ?? '';
    final url = Uri.parse(
        '$_baseUrlf?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to fetch forecast data');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching forecast data: $error');
      }
      return null;
    }
  }
}
