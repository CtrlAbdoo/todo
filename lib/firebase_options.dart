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
    apiKey: 'AIzaSyDqiB5kJS_cBBMmE0MOHagcRmOKf6lBVr0',
    appId: '1:692517272269:web:70819222d730060a8f8784',
    messagingSenderId: '692517272269',
    projectId: 'todo-cd30b',
    authDomain: 'todo-cd30b.firebaseapp.com',
    storageBucket: 'todo-cd30b.appspot.com',
    measurementId: 'G-79ZFPTQTQF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCx3_oUY-DAvpjP3qxPVLwBZwKn5K-o5Yg',
    appId: '1:692517272269:android:c9ee16c2160c4c6b8f8784',
    messagingSenderId: '692517272269',
    projectId: 'todo-cd30b',
    storageBucket: 'todo-cd30b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBouC1ODuCU_Oa2Vf40WVxWuAIMFV9M7hE',
    appId: '1:692517272269:ios:bf1d485df41787028f8784',
    messagingSenderId: '692517272269',
    projectId: 'todo-cd30b',
    storageBucket: 'todo-cd30b.appspot.com',
    iosBundleId: 'com.example.todo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBouC1ODuCU_Oa2Vf40WVxWuAIMFV9M7hE',
    appId: '1:692517272269:ios:51a8f9ccd33251838f8784',
    messagingSenderId: '692517272269',
    projectId: 'todo-cd30b',
    storageBucket: 'todo-cd30b.appspot.com',
    iosBundleId: 'com.example.todo.RunnerTests',
  );
}
