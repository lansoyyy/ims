import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ims/firebase_options.dart';
import 'package:ims/screens/coach_home_screen.dart';
import 'package:ims/screens/coach_screen.dart';
import 'package:ims/screens/home_screen.dart';
import 'package:ims/screens/login_screen.dart';
import 'package:ims/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'information-management-s-9f909',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginScreen(),
    );
  }
}
