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
    apiKey: 'AIzaSyD8jZFtdMttlyOJjEvTgEnf9XmEf_xhD98',
    appId: '1:248752298546:web:bf507477433982dbd6fa2b',
    messagingSenderId: '248752298546',
    projectId: 'chat-app-28077',
    authDomain: 'chat-app-28077.firebaseapp.com',
    storageBucket: 'chat-app-28077.appspot.com',
    measurementId: 'G-EBPJP98LWR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA1-qvKUheRLEKVcH5bavPJXEvcwrSqQVc',
    appId: '1:248752298546:android:6569104d812cddf2d6fa2b',
    messagingSenderId: '248752298546',
    projectId: 'chat-app-28077',
    storageBucket: 'chat-app-28077.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDuwHUAyBgWXVC7_aAIM8GfCJc4LvUZULA',
    appId: '1:248752298546:ios:a0a5dcbd1ff87019d6fa2b',
    messagingSenderId: '248752298546',
    projectId: 'chat-app-28077',
    storageBucket: 'chat-app-28077.appspot.com',
    iosBundleId: 'com.example.chatsProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDuwHUAyBgWXVC7_aAIM8GfCJc4LvUZULA',
    appId: '1:248752298546:ios:a0a5dcbd1ff87019d6fa2b',
    messagingSenderId: '248752298546',
    projectId: 'chat-app-28077',
    storageBucket: 'chat-app-28077.appspot.com',
    iosBundleId: 'com.example.chatsProject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD8jZFtdMttlyOJjEvTgEnf9XmEf_xhD98',
    appId: '1:248752298546:web:80b70a258018fcfad6fa2b',
    messagingSenderId: '248752298546',
    projectId: 'chat-app-28077',
    authDomain: 'chat-app-28077.firebaseapp.com',
    storageBucket: 'chat-app-28077.appspot.com',
    measurementId: 'G-QDW15FWHCC',
  );
}