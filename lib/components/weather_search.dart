// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_forecasting/search_info.dart';

class SearchWeather extends StatefulWidget {
  const SearchWeather({super.key});

  @override
  State<SearchWeather> createState() => _SearchWeather();
}

class _SearchWeather extends State<SearchWeather> {
  final _SearchWeatherController = TextEditingController();
  String? cityName;
  double lat = 0.0;
  double lon = 0.0;

  //get coordinates from the city name
  Future<Map<String, double>?> getCoordinatesFromCity(String cityName) async {
    try {
      // Use the locationFromAddress method to get coordinates
      List<Location> locations = await locationFromAddress(cityName);

      if (locations.isNotEmpty) {
        double latitude = locations[0].latitude;
        double longitude = locations[0].longitude;

        if (kDebugMode) {
          print(
              'Coordinates of $cityName: Latitude: $latitude, Longitude: $longitude');
        }

        // Return the latitude and longitude in a map
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/background.jpg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 100,
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
                        ]),
                    height: 55,
                    width: MediaQuery.of(context).size.width / 1.5,
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
                          )),
                      onChanged: (value) {
                        cityName = value;
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      // Ensure fetchCoordinates finishes execution before navigating
                      await fetchCoordinates(cityName!);

                      // Once fetchCoordinates completes, navigate to SearchInfo
                      Navigator.push(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchInfo(lat, lon),
                        ),
                      );
                    },
                    child: Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width / 4,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff4b4f85),
                            offset: Offset(0, 18),
                            blurRadius: 20,
                            spreadRadius: -12,
                          ),
                        ],
                        color: Colors.orange,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: const Center(
                          child: Text("Search",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18))),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
