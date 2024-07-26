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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC5M8xb1naXgi5U0gywOeqB7N1hzvLNeMY',
    appId: '1:249073929156:android:f538117eb5fe2827c0f291',
    messagingSenderId: '249073929156',
    projectId: 'jagruk-7ca8e',
    databaseURL: 'https://jagruk-7ca8e-default-rtdb.firebaseio.com',
    storageBucket: 'jagruk-7ca8e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-Gtk1L7ykJSy7EzofxjVJzyW8t7kSt4M',
    appId: '1:249073929156:ios:42fe774a5878028ec0f291',
    messagingSenderId: '249073929156',
    projectId: 'jagruk-7ca8e',
    databaseURL: 'https://jagruk-7ca8e-default-rtdb.firebaseio.com',
    storageBucket: 'jagruk-7ca8e.appspot.com',
    iosBundleId: 'com.example.jagruk',
  );

}