import 'package:flutter/material.dart';
import 'screens/signin_page.dart';
import 'screens/splash_screen.dart';
import 'screens/storage_page.dart';
import 'screens/connected_devices_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vigilante Net',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const SignInPage(),
        '/storage': (context) => const StoragePage(),
      },
    );
  }
}
