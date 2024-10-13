// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDKh_0DvwuplU8qwU2ortepKiQp5ANq-Ok',
    appId: '1:458126606920:web:c437b4cbe73edc478a4e7d',
    messagingSenderId: '458126606920',
    projectId: 'weather-app-79c1f',
    authDomain: 'weather-app-79c1f.firebaseapp.com',
    storageBucket: 'weather-app-79c1f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAHb-uyPa5giLSxEJvICfVCAKM-Aqu0rlg',
    appId: '1:458126606920:android:0cd755b8fa37f9e78a4e7d',
    messagingSenderId: '458126606920',
    projectId: 'weather-app-79c1f',
    storageBucket: 'weather-app-79c1f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAtahaZuj43pJ96uPq9I4WNk64lU1h2gHE',
    appId: '1:458126606920:ios:b2b6c0823ef4695d8a4e7d',
    messagingSenderId: '458126606920',
    projectId: 'weather-app-79c1f',
    storageBucket: 'weather-app-79c1f.appspot.com',
    iosBundleId: 'com.example.weatherForecasting',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAtahaZuj43pJ96uPq9I4WNk64lU1h2gHE',
    appId: '1:458126606920:ios:b2b6c0823ef4695d8a4e7d',
    messagingSenderId: '458126606920',
    projectId: 'weather-app-79c1f',
    storageBucket: 'weather-app-79c1f.appspot.com',
    iosBundleId: 'com.example.weatherForecasting',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDKh_0DvwuplU8qwU2ortepKiQp5ANq-Ok',
    appId: '1:458126606920:web:66f09f4e67629bba8a4e7d',
    messagingSenderId: '458126606920',
    projectId: 'weather-app-79c1f',
    authDomain: 'weather-app-79c1f.firebaseapp.com',
    storageBucket: 'weather-app-79c1f.appspot.com',
  );
}
