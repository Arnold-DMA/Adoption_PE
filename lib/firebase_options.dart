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
    apiKey: 'AIzaSyBxPgacbnpBlNVRgDUwNqpj4qWot-fI5js',
    appId: '1:19513703906:web:fd56a0f29661b793e00dbb',
    messagingSenderId: '19513703906',
    projectId: 'pets-29f0b',
    authDomain: 'pets-29f0b.firebaseapp.com',
    storageBucket: 'pets-29f0b.appspot.com',
    measurementId: 'G-FWDJFKVV5C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA-EFSd0GZvZf2aQ7-htdAlRj6PKfRCQrg',
    appId: '1:19513703906:android:d8df326d237a949ee00dbb',
    messagingSenderId: '19513703906',
    projectId: 'pets-29f0b',
    storageBucket: 'pets-29f0b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBNPPAtLNewbadF0MreR2G9sfMa7XMxq9Y',
    appId: '1:19513703906:ios:c0fa235604b6ed95e00dbb',
    messagingSenderId: '19513703906',
    projectId: 'pets-29f0b',
    storageBucket: 'pets-29f0b.appspot.com',
    iosClientId: '19513703906-pftup2r5973u9n1ldrld33lkcmpbr8lf.apps.googleusercontent.com',
    iosBundleId: 'com.example.adoptionPe',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBNPPAtLNewbadF0MreR2G9sfMa7XMxq9Y',
    appId: '1:19513703906:ios:c0fa235604b6ed95e00dbb',
    messagingSenderId: '19513703906',
    projectId: 'pets-29f0b',
    storageBucket: 'pets-29f0b.appspot.com',
    iosClientId: '19513703906-pftup2r5973u9n1ldrld33lkcmpbr8lf.apps.googleusercontent.com',
    iosBundleId: 'com.example.adoptionPe',
  );
}
