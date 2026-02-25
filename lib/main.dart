import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:small_social_app/features/auth/presentation/pages/login.dart';
import 'package:small_social_app/themes/darkmode.dart';
import 'package:small_social_app/themes/lightmode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
