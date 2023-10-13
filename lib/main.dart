import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Providers/AuthProvider.dart';
import 'package:todo/UI/Home/HomeScreen.dart';
import 'package:todo/UI/Login/LoginScreen.dart';
import 'package:todo/UI/Register/RegisterScreen.dart';
import 'package:todo/firebase_options.dart';

final authProvider = AuthProvider();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await authProvider.checkAuthenticationStatus();

  runApp(
    ChangeNotifierProvider<AuthProvider>.value(
      value: authProvider,
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF5D9CEC),
          primary: Color(0xFF5D9CEC),
          primaryContainer: Color(0xFFFFFFFF)
        ),
        useMaterial3: true,
      ),
      routes: {
        RegisterScreen.routeName: (_)=>RegisterScreen(),
        LoginScreen.routeName: (_)=>LoginScreen(),
        HomeScreen.routeName: (_)=> HomeScreen(),
      },
      initialRoute: authProvider.firebaseAuthUser != null
          ? HomeScreen.routeName
          : LoginScreen.routeName,
    );
  }
}



