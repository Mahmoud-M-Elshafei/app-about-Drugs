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
    apiKey: 'AIzaSyDXnR5_0FdnNjajsobnN9lX0ONK9sl9p9o',
    appId: '1:232878183426:web:524c9ec0c33cde65afc31b',
    messagingSenderId: '232878183426',
    projectId: 'my11-158ff',
    authDomain: 'my11-158ff.firebaseapp.com',
    databaseURL: 'https://my11-158ff-default-rtdb.firebaseio.com',
    storageBucket: 'my11-158ff.appspot.com',
    measurementId: 'G-JW45B4VKYQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDKEqlJbyOwpkQw0LL949mklFHq4AnYg9g',
    appId: '1:232878183426:android:432eaa7fcd776568afc31b',
    messagingSenderId: '232878183426',
    projectId: 'my11-158ff',
    databaseURL: 'https://my11-158ff-default-rtdb.firebaseio.com',
    storageBucket: 'my11-158ff.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCMUB1AU5wMEDzZYTh0gpChOTzXwWxirh8',
    appId: '1:232878183426:ios:86774d2449970a27afc31b',
    messagingSenderId: '232878183426',
    projectId: 'my11-158ff',
    databaseURL: 'https://my11-158ff-default-rtdb.firebaseio.com',
    storageBucket: 'my11-158ff.appspot.com',
    iosBundleId: 'com.elshafei.flutterproject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCMUB1AU5wMEDzZYTh0gpChOTzXwWxirh8',
    appId: '1:232878183426:ios:86774d2449970a27afc31b',
    messagingSenderId: '232878183426',
    projectId: 'my11-158ff',
    databaseURL: 'https://my11-158ff-default-rtdb.firebaseio.com',
    storageBucket: 'my11-158ff.appspot.com',
    iosBundleId: 'com.elshafei.flutterproject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDXnR5_0FdnNjajsobnN9lX0ONK9sl9p9o',
    appId: '1:232878183426:web:f630b5d14b759af4afc31b',
    messagingSenderId: '232878183426',
    projectId: 'my11-158ff',
    authDomain: 'my11-158ff.firebaseapp.com',
    databaseURL: 'https://my11-158ff-default-rtdb.firebaseio.com',
    storageBucket: 'my11-158ff.appspot.com',
    measurementId: 'G-NXNW3JYMX9',
  );

}