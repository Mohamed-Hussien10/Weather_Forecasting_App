import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static double latitude = 0.0;
  static double longitude = 0.0;

  Future<void> fetchLocation(Function(double, double) onLocationFetched) async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          throw Exception('Location permissions are denied.');
        }
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Update the static latitude and longitude variables
      latitude = position.latitude;
      longitude = position.longitude;

      // Call the callback with the new location
      onLocationFetched(latitude, longitude); // Pass updated coordinates
      if (kDebugMode) {
        print('Location fetched: $latitude, $longitude');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching location: $e');
      }
    }
  }
}
