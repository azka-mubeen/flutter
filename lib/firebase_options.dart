
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
    apiKey: 'AIzaSyAH0htwsaWZLyaAjIN9-_PdKfJbmkGzslk',
    appId: '1:770948491535:web:f911a9618dd9f5e68f367a',
    messagingSenderId: '770948491535',
    projectId: 'tailor-9f29a',
    authDomain: 'tailor-9f29a.firebaseapp.com',
    storageBucket: 'tailor-9f29a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDHPfECbaQYX-tPq6jwBkuMY96MRkGHyjg',
    appId: '1:770948491535:android:48d75aa5c7cf1fc78f367a',
    messagingSenderId: '770948491535',
    projectId: 'tailor-9f29a',
    storageBucket: 'tailor-9f29a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAOYNYfecmM5JeiNNLVRpHRYWPsFEPpu3M',
    appId: '1:770948491535:ios:e16b598c0b3788308f367a',
    messagingSenderId: '770948491535',
    projectId: 'tailor-9f29a',
    storageBucket: 'tailor-9f29a.appspot.com',
    iosBundleId: 'com.example.tailorAssistant',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAOYNYfecmM5JeiNNLVRpHRYWPsFEPpu3M',
    appId: '1:770948491535:ios:e16b598c0b3788308f367a',
    messagingSenderId: '770948491535',
    projectId: 'tailor-9f29a',
    storageBucket: 'tailor-9f29a.appspot.com',
    iosBundleId: 'com.example.tailorAssistant',
  );
}
