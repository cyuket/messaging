// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCVBfJhmFNSH5aJmaArrDrUUiIJjzNgyXY',
    appId: '1:454496946911:web:c7a86235e7b01df45af76a',
    messagingSenderId: '454496946911',
    projectId: 'messaging-62964',
    authDomain: 'messaging-62964.firebaseapp.com',
    storageBucket: 'messaging-62964.appspot.com',
    measurementId: 'G-GYBRBFK5QQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDewyvBaneLkCgrt1BFRxHvqvNwTeEZB2s',
    appId: '1:454496946911:android:de83af0f06684adf5af76a',
    messagingSenderId: '454496946911',
    projectId: 'messaging-62964',
    storageBucket: 'messaging-62964.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAGeaY7rFMTvIS0LygHaNKRjZOver1rw2w',
    appId: '1:454496946911:ios:addeccbe1f2c2b565af76a',
    messagingSenderId: '454496946911',
    projectId: 'messaging-62964',
    storageBucket: 'messaging-62964.appspot.com',
    iosClientId: '454496946911-k7u6nhstlc00ekjmfne4qqsk9cgslb1k.apps.googleusercontent.com',
    iosBundleId: 'com.messaging.app',
  );
}
