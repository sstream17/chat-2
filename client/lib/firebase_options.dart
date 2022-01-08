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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBGlSUzjlc3SOR7hMhnrBofqU7-IMrFc6Q',
    appId: '1:930214593047:android:179c4fe653db10e9ff5252',
    messagingSenderId: '930214593047',
    projectId: 'link-chat-a213b',
    storageBucket: 'link-chat-a213b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBaiWJ1TgpZ91s8LXwzBKA48Wr2X4BF9NM',
    appId: '1:930214593047:ios:af5eded3eaad307eff5252',
    messagingSenderId: '930214593047',
    projectId: 'link-chat-a213b',
    storageBucket: 'link-chat-a213b.appspot.com',
    iosClientId: '930214593047-kth8invj2s6r4nd297qcpfhsog4cuqpp.apps.googleusercontent.com',
    iosBundleId: 'com.stream-suite.link',
  );
}
