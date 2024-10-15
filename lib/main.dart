import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_forecasting/api/firebase_api.dart';
import 'package:weather_forecasting/weather_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WeatherInfo(),
      theme: ThemeData(fontFamily: "AfacadFlux"),
    );
  }
}

// color: Color(0xff0c0c0c),   black
// color: Color(0xff212224),   grey
// color: Color(0xffed8b01),   orange
// color: Color(0xff414475),   dark blue