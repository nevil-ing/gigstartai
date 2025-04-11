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
    apiKey: 'AIzaSyB_lHYo3FokhQaR4xteSfYPB7v-sa0Sub4',
    appId: '1:930928729992:web:aeb0c1a06f1d054cd7643d',
    messagingSenderId: '930928729992',
    projectId: 'gig-star',
    authDomain: 'gig-star.firebaseapp.com',
    storageBucket: 'gig-star.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDwO36aCuvw7v2Q-vILD0ohC0ir4ZrtSIY',
    appId: '1:930928729992:android:15c88f930efdfdbdd7643d',
    messagingSenderId: '930928729992',
    projectId: 'gig-star',
    storageBucket: 'gig-star.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAckcJbLEYLUjujL0UTGhx_ufF_QNN3D50',
    appId: '1:930928729992:ios:6a74b804237bfc84d7643d',
    messagingSenderId: '930928729992',
    projectId: 'gig-star',
    storageBucket: 'gig-star.firebasestorage.app',
    iosBundleId: 'com.example.gigstartai',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAckcJbLEYLUjujL0UTGhx_ufF_QNN3D50',
    appId: '1:930928729992:ios:6a74b804237bfc84d7643d',
    messagingSenderId: '930928729992',
    projectId: 'gig-star',
    storageBucket: 'gig-star.firebasestorage.app',
    iosBundleId: 'com.example.gigstartai',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB_lHYo3FokhQaR4xteSfYPB7v-sa0Sub4',
    appId: '1:930928729992:web:4a255321a1378daed7643d',
    messagingSenderId: '930928729992',
    projectId: 'gig-star',
    authDomain: 'gig-star.firebaseapp.com',
    storageBucket: 'gig-star.firebasestorage.app',
  );
}
