// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCCqFlIQ5gPPQ0wtUgk7mq70zDcgPqud2w',
    appId: '1:522636415020:web:32f344cd5c3086f6d00189',
    messagingSenderId: '522636415020',
    projectId: 'lipi-app',
    authDomain: 'lipi-app.firebaseapp.com',
    storageBucket: 'lipi-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAtDt5DZ7giQEJwrQTFHF-hHOly-foK1Gc',
    appId: '1:522636415020:android:b465580c1d16689fd00189',
    messagingSenderId: '522636415020',
    projectId: 'lipi-app',
    storageBucket: 'lipi-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDlaG_DdDwfPjJ9AP160XEWpPq8O7fhjDo',
    appId: '1:522636415020:ios:9bbb74bc4cbfd3dcd00189',
    messagingSenderId: '522636415020',
    projectId: 'lipi-app',
    storageBucket: 'lipi-app.appspot.com',
    iosBundleId: 'com.example.lipi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDlaG_DdDwfPjJ9AP160XEWpPq8O7fhjDo',
    appId: '1:522636415020:ios:ec68da7c87e5b59ad00189',
    messagingSenderId: '522636415020',
    projectId: 'lipi-app',
    storageBucket: 'lipi-app.appspot.com',
    iosBundleId: 'com.example.lipi.RunnerTests',
  );
}