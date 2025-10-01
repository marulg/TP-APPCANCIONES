import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyCDTQfbgokm-z2L_remDAYeOJylLrHip_U',
    appId: '1:630540311839:web:49d226907f3d14e2d2242a',
    messagingSenderId: '630540311839',
    projectId: 'dap-firebase-73cc8',
    authDomain: 'dap-firebase-73cc8.firebaseapp.com',
    storageBucket: 'dap-firebase-73cc8.firebasestorage.app',
    measurementId: 'G-LK4Q11J1GS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC7PWZdrkC3LSJOqpls-EIim31PT0VjkTk',
    appId: '1:630540311839:android:64a2ef9263854a76d2242a',
    messagingSenderId: '630540311839',
    projectId: 'dap-firebase-73cc8',
    storageBucket: 'dap-firebase-73cc8.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDI1GTttn6WgvcP46stMP75gr5QQC1I5hk',
    appId: '1:630540311839:ios:721f914c267525a1d2242a',
    messagingSenderId: '630540311839',
    projectId: 'dap-firebase-73cc8',
    storageBucket: 'dap-firebase-73cc8.firebasestorage.app',
    iosBundleId: 'com.example.clases',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDI1GTttn6WgvcP46stMP75gr5QQC1I5hk',
    appId: '1:630540311839:ios:721f914c267525a1d2242a',
    messagingSenderId: '630540311839',
    projectId: 'dap-firebase-73cc8',
    storageBucket: 'dap-firebase-73cc8.firebasestorage.app',
    iosBundleId: 'com.example.clases',
  );
}
