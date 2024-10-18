// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecasting/dialog.dart';
import 'package:weather_forecasting/services/weather_service.dart';

class SearchWeather extends StatefulWidget {
  const SearchWeather({super.key});

  @override
  State<SearchWeather> createState() => _SearchWeather();
}

class _SearchWeather extends State<SearchWeather> {
  String formattedDate =
      DateFormat('EEEE, d, MMMM, h:mm a').format(DateTime.now());
  String day = DateFormat('a').format(DateTime.now());
  String hour = DateFormat('h').format(DateTime.now());
  final _SearchWeatherController = TextEditingController();
  final WeatherService weatherService = WeatherService();

  bool _isLoading = false; // Track loading state
  String? cityName;
  double lat = 0.0;
  double lon = 0.0;

  // Get coordinates from the city name
  Future<Map<String, double>?> getCoordinatesFromCity(String cityName) async {
    try {
      List<Location> locations = await locationFromAddress(cityName);

      if (locations.isNotEmpty) {
        double latitude = locations[0].latitude;
        double longitude = locations[0].longitude;

        if (kDebugMode) {
          print(
              'Coordinates of $cityName: Latitude: $latitude, Longitude: $longitude');
        }

        return {
          'latitude': latitude,
          'longitude': longitude,
        };
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
    return null; // Return null if no location is found or an error occurs
  }

  Future<void> fetchCoordinates(String cityname) async {
    Map<String, double>? coordinates = await getCoordinatesFromCity(cityname);

    if (coordinates != null) {
      lat = coordinates['latitude']!;
      lon = coordinates['longitude']!;
    }
  }

  Future<Map<String, dynamic>?> _getWeather() async {
    if (kDebugMode) {
      print("Searching for weather: $lat $lon");
    }
    // Fetch the weather data
    return await weatherService.fetchWeatherData(lat, lon);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Center(
          child: Text(
            "Search City",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
        backgroundColor: const Color(0xff2f2365),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            "assets/images/background.jpg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          if (_isLoading) // Show loading indicator if loading
            const Center(
              child: CircularProgressIndicator(),
            ),
          Positioned(
            top: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xff414475),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff4b4f85),
                          offset: Offset(0, 18),
                          blurRadius: 20,
                          spreadRadius: -12,
                        ),
                      ],
                    ),
                    height: 55,
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: TextField(
                      controller: _SearchWeatherController,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      decoration: const InputDecoration(
                        labelText: "Search",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        hintText: "Enter City Name",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        fillColor: Color(0xff353a5e),
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        cityName = value;
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        _isLoading = true; // Set loading state to true
                      });

                      await fetchCoordinates(cityName!);
                      final Map<String, dynamic>? weather = await _getWeather();

                      setState(() {
                        _isLoading = false; // Set loading state to false
                      });

                      final String desp = weather?['weather'][0]['description'];
                      late String icon;
                      if (desp.contains('clouds')) {
                        icon = 'clouds';
                      } else if (desp.contains('clear') && day == 'AM' ||
                          double.parse(hour) >= 1 && double.parse(hour) <= 6) {
                        icon = 'clearlight';
                      } else if (desp.contains('clear') && day == 'PM') {
                        icon = 'clearnight';
                      } else if (desp.contains('rain')) {
                        icon = 'rain';
                      } else if (desp.contains('wind')) {
                        icon = 'wind';
                      } else if (desp.contains('snow')) {
                        icon = 'snow';
                      }

                      if (weather != null) {
                        // Show the dialog with the weather information
                        String temp = weather['main']['temp'].toString();
                        String tempMax = weather['main']['temp_max'].toString();
                        String tempMin = weather['main']['temp_min'].toString();
                        String feelsLike =
                            weather['main']['feels_like'].toString();
                        String formattedDate =
                            DateFormat('EEEE, d, MMMM, h:mm a')
                                .format(DateTime.now());
                        String weatherDescription =
                            weather['weather'][0]['description'];
                        // Show the dialog with the weather information
                        showDialog<void>(
                          // ignore: use_build_context_synchronously
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return WeatherDialog(
                              temp: temp,
                              tempMax: tempMax,
                              tempMin: tempMin,
                              feelsLike: feelsLike,
                              formattedDate: formattedDate,
                              weatherDescription: weatherDescription,
                              icon: icon,
                            );
                          },
                        );
                      } else {
                        // Handle case when weather is null (e.g., show an error message)
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('No weather data available.')),
                        );
                      }
                    },
                    child: Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width / 6,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
