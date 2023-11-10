import 'package:flutter/material.dart';
import 'package:indoornav/Screens/CameraScreen.dart';
import 'package:indoornav/Screens/HomeScreen.dart';
import 'package:indoornav/Screens/MapScreen.dart';
import 'package:indoornav/Screens/SignInScreen.dart';
import 'package:indoornav/Screens/SignUpScreen.dart';
import 'package:indoornav/Screens/SignInScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: SignInScreen.id,
      routes: {
        SignInScreen.id: (context) => const SignInScreen(),
        SignUpScreen.id: (context) => const SignUpScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        CameraScreen.id: (context) => CameraScreen(),
        MapScreen.id: (context) => MapScreen(),
        // MapScreen.id: (context) => MapScreen(
        //     base64Image: ModalRoute.of(context)!.settings.arguments as String),
      },
    );
  }
}
