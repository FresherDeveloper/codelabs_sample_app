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
    apiKey: 'AIzaSyC9fk11SDoV1Q4PlOvm5oReY5TnAowTfJU',
    appId: '1:865105563795:web:681e87b94a6fffca64bd66',
    messagingSenderId: '865105563795',
    projectId: 'fir-demo-82135',
    authDomain: 'fir-demo-82135.firebaseapp.com',
    storageBucket: 'fir-demo-82135.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDRCpBfcp_j2Roa2L5SdcUy-lBda9P173k',
    appId: '1:865105563795:android:b2a6b53c09ea788864bd66',
    messagingSenderId: '865105563795',
    projectId: 'fir-demo-82135',
    storageBucket: 'fir-demo-82135.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCkOmBsleWgZWn3jcx5YDCyyUjwD7MkChw',
    appId: '1:865105563795:ios:32a86658c855991464bd66',
    messagingSenderId: '865105563795',
    projectId: 'fir-demo-82135',
    storageBucket: 'fir-demo-82135.appspot.com',
    iosBundleId: 'com.example.coinoneSampleApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCkOmBsleWgZWn3jcx5YDCyyUjwD7MkChw',
    appId: '1:865105563795:ios:32a86658c855991464bd66',
    messagingSenderId: '865105563795',
    projectId: 'fir-demo-82135',
    storageBucket: 'fir-demo-82135.appspot.com',
    iosBundleId: 'com.example.coinoneSampleApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC9fk11SDoV1Q4PlOvm5oReY5TnAowTfJU',
    appId: '1:865105563795:web:b47706e3b2d36b4b64bd66',
    messagingSenderId: '865105563795',
    projectId: 'fir-demo-82135',
    authDomain: 'fir-demo-82135.firebaseapp.com',
    storageBucket: 'fir-demo-82135.appspot.com',
  );
}